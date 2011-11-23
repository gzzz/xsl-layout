<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:layout="http://groundzero.ru/layout/"
	xmlns:og="http://ogp.me/ns#"
	extension-element-prefixes="layout og"
>

	<xsl:import href="layout.xsl"/>

	<xsl:template match="layout:html" mode="node">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text><!-- HTML5 -->
		<xsl:apply-imports/>
	</xsl:template>

	<xsl:template match="layout:charset" mode="node">
		<meta charset="UTF-8"/>
	</xsl:template>


	<xsl:template match="layout:title" mode="content">
		<xsl:text>Test project</xsl:text>
	</xsl:template>

	<xsl:template match="layout:description" mode="content">
		<xsl:value-of select="$content/meta/description"/>
	</xsl:template>

	<xsl:template match="layout:keywords" mode="content">
		<xsl:value-of select="$content/meta/keywords"/>
	</xsl:template>


	<xsl:template match="layout:styles" mode="node">
		<link href="/css/reset-min.css" rel="stylesheet"/>
		<link href="/css/default.css" rel="stylesheet"/>
	</xsl:template>

	<xsl:template match="layout:scripts" mode="node">
		<script src="/js/common.js"/>
	</xsl:template>

	<xsl:template match="layout:header" mode="content">
		<xsl:text>default header</xsl:text>
	</xsl:template>

	<xsl:template match="layout:navigation" mode="content">
		<a href="">i</a><xsl:text> </xsl:text>
		<a href="">am</a><xsl:text> </xsl:text>
		<a href="">the</a><xsl:text> </xsl:text>
		<a href="">navigation</a>
	</xsl:template>

	<xsl:template match="layout:search" mode="content">
		<xsl:text>search!</xsl:text>
	</xsl:template>

	<xsl:template match="layout:left" mode="content">
		<xsl:text>banners here</xsl:text>
	</xsl:template>

	<xsl:template match="layout:footer" mode="content">
		<xsl:text>usage: </xsl:text>
		<xsl:value-of select="$content/rusage"/>
	</xsl:template>

	<xsl:template match="layout:copyright" mode="node">
		<a id="copyright">© gz, 2011</a>
	</xsl:template>

	<xsl:template match="layout:title" mode="content">
		<xsl:text>The layout project</xsl:text>
	</xsl:template>

	<xsl:template match="layout:crumbs" mode="content">
		<a href="/">The layout project</a>
	</xsl:template>

	<xsl:template match="layout:right" mode="content">
		<xsl:apply-templates select="$content/data" mode="list"/>
	</xsl:template>


	<xsl:template match="data" mode="list">
		<ul>
			<xsl:apply-templates mode="item"/>
		</ul>
	</xsl:template>

	<xsl:template match="item" mode="item">
		<li>
			<a href="/{@id}">
				<xsl:value-of select="."/>
			</a>
		</li>
	</xsl:template>

</xsl:stylesheet>