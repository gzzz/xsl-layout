<?xml version="1.0" encoding="utf-8" ?>

<!--
	Общая сетка страницы.
	Дерево документа хранится в layout.xml.
	Режим node — вывод узла,
	режим content — вывод содержимого.

	Перекрывать обычно нужно только mode="content",
	mode="node" — только если необходимо полностью изменить формирование узла.
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:layout="http://groundzero.ru/layout/"
	xmlns:og="http://ogp.me/ns#"
	extension-element-prefixes="layout og"
>

	<xsl:param name="layout-name">layout</xsl:param>
	<!-- структура документа -->
	<xsl:variable name="layout" select="document(concat($layout-name, '.xml'))/layout:html"/>


	<!-- по умолчанию начинаем строить структуру страницы -->
	<xsl:template match="/">
		<xsl:apply-templates select="$layout" mode="node"/>
	</xsl:template>


	<!-- применяется ко всем узлам, выдаёт div="имя-узла", зовёт шаблоны дочерних узлов -->
	<xsl:template match="layout:*" mode="node">
		<div id="{local-name()}">
			<xsl:apply-templates select="." mode="begin"/>
			<xsl:apply-templates mode="node"/>
			<xsl:apply-templates select="." mode="content"/>
			<xsl:apply-templates select="." mode="end"/>
		</div>
	</xsl:template>

	<!-- применяется к html, head, body и title, выдаёт узел с заданным именем, зовёт шаблоны дочерних узлов -->
	<xsl:template match="layout:html|layout:head|layout:body|layout:title" mode="node">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="." mode="begin"/>
			<xsl:apply-templates mode="node"/>
			<xsl:apply-templates select="." mode="content"/>
			<xsl:apply-templates select="." mode="end"/>
		</xsl:element>
	</xsl:template>

	<!-- применяется к meta, stiles и scripts, не генерирует узел, сразу зовёт шаблоны дочерних узлов -->
	<xsl:template match="layout:meta|layout:styles|layout:scripts" mode="node">
		<xsl:apply-templates select="." mode="begin"/>
		<xsl:apply-templates mode="node"/>
		<xsl:apply-templates select="." mode="content"/>
		<xsl:apply-templates select="." mode="end"/>
	</xsl:template>

	<!-- применяется к узлам в meta, генерирует узел meta, зовёт шаблоны для получения атрибута content -->
	<!-- приоритет занижен, чтобы можно было перекрыть шаблоном без указания в match родителя -->
	<xsl:template match="layout:meta/layout:*" mode="node" priority="0">
		<meta name="{local-name()}">
			<xsl:attribute name="content">
				<xsl:apply-templates select="." mode="content"/>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<!-- применяется к узлам в meta с не-layout пространством имён, генерирует узел meta, зовёт шаблоны для получения атрибута content -->
	<xsl:template match="layout:meta/*" mode="node" priority="-0.1">
		<meta name="{name()}">
			<xsl:attribute name="content">
				<xsl:apply-templates select="." mode="content"/>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<!-- по умолчанию никакое текстовое содержимое не выводим -->
	<xsl:template match="layout:*" mode="content"/>
	<xsl:template match="layout:*" mode="begin"/>
	<xsl:template match="layout:*" mode="end"/>

</xsl:stylesheet>