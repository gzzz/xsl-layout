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
	xmlns:l="http://groundzero.ru/layout/"
	xmlns:og="http://ogp.me/ns#"
	extension-element-prefixes="l og"
>

	<xsl:param name="l:layout-name">layout</xsl:param>
	<!-- структура документа -->
	<xsl:variable name="l:layout" select="document(concat($l:layout-name, '.xml'))/l:html"/>


	<!-- по умолчанию начинаем строить структуру страницы -->
	<xsl:template match="/">
		<xsl:apply-templates select="$l:layout" mode="node"/>
	</xsl:template>


	<!-- применяется ко всем узлам, выдаёт div id="имя-узла", зовёт шаблоны дочерних узлов -->
	<xsl:template match="l:*" mode="node">
		<div id="{local-name()}">
			<xsl:apply-templates mode="node"/>
			<xsl:apply-templates select="." mode="content"/>
		</div>
	</xsl:template>

	<!-- применяется к html, head, body и title, выдаёт узел с заданным именем, зовёт шаблоны дочерних узлов -->
	<xsl:template match="l:html|l:head|l:body|l:title" mode="node">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates mode="node"/>
			<xsl:apply-templates select="." mode="content"/>
		</xsl:element>
	</xsl:template>

	<!-- применяется к meta, styles и scripts, не генерирует узел, сразу зовёт шаблоны дочерних узлов -->
	<xsl:template match="l:meta|l:styles|l:scripts" mode="node">
		<xsl:apply-templates mode="node"/>
		<xsl:apply-templates select="." mode="content"/>
	</xsl:template>

	<!-- применяется к узлам в meta, генерирует узел meta, зовёт шаблоны для получения атрибута content -->
	<!-- приоритет занижен, чтобы можно было перекрыть шаблоном без указания в match родителя -->
	<xsl:template match="l:meta/l:*" mode="node" priority="0">
		<meta name="{local-name()}">
			<xsl:attribute name="content">
				<xsl:apply-templates select="." mode="content"/>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<!-- применяется к canonical, генерирует узел канонического адреса -->
	<xsl:template match="l:meta/l:canonical" mode="node">
		<link rel="canonical">
			<xsl:attribute name="href">
				<xsl:apply-templates select="." mode="content"/>
			</xsl:attribute>
		</link>
	</xsl:template>

	<!-- применяется к узлам в meta с не-layout пространством имён, генерирует узел meta, зовёт шаблоны для получения атрибута content -->
	<xsl:template match="l:meta/*" mode="node" priority="-0.1">
		<meta name="{name()}">
			<xsl:attribute name="content">
				<xsl:apply-templates select="." mode="content"/>
			</xsl:attribute>
		</meta>
	</xsl:template>

	<!-- по умолчанию никакое текстовое содержимое не выводим -->
	<xsl:template match="l:*" mode="content"/>

</xsl:stylesheet>