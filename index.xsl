<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:l="http://groundzero.ru/layout/"
	xmlns:og="http://ogp.me/ns#"
	extension-element-prefixes="l og"
>

	<xsl:import href="default.xsl"/>

	<xsl:variable name="content" select="/doc"/>

	<xsl:template match="l:styles" mode="node">
		<xsl:apply-imports/>
		<link href="/css/index.css" rel="stylesheet"/>
	</xsl:template>

	<xsl:template match="l:title" mode="content">
		<xsl:apply-imports/>
		<xsl:text> / </xsl:text>
		<xsl:value-of select="$content/data/@title"/>
	</xsl:template>

	<xsl:template match="l:canonical" mode="content">
		<xsl:text>/</xsl:text>
	</xsl:template>

	<xsl:template match="l:crumbs" mode="content">
		<xsl:apply-imports/>
		<xsl:text> / </xsl:text>
		<xsl:value-of select="$content/data/@title"/>
	</xsl:template>

	<xsl:template match="l:right" mode="content">
		<xsl:text>we are deep inside!</xsl:text>
		<br/>
		<xsl:apply-imports/>
	</xsl:template>

	<xsl:template match="l:description" mode="content">
		<xsl:apply-imports/>
		<xsl:text>, some addition</xsl:text>
	</xsl:template>

</xsl:stylesheet>