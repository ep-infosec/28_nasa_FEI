<?xml version="1.0"?>
<!--********************************************************************************
 * CruiseControl, a Continuous Integration Toolkit
 * Copyright (c) 2001, ThoughtWorks, Inc.
 * 651 W Washington Ave. Suite 500
 * Chicago, IL 60661 USA
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *     + Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *
 *     + Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *
 *     + Neither the name of ThoughtWorks, Inc., CruiseControl, nor the
 *       names of its contributors may be used to endorse or promote
 *       products derived from this software without specific prior
 *       written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 ********************************************************************************-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:lxslt="http://xml.apache.org/xslt">

    <xsl:output method="html"/>
    <xsl:variable name="modification.list" select="cruisecontrol/modifications/changelist"/>

    <xsl:template match="/">
        <table align="center" cellpadding="2" cellspacing="1" border="0" width="98%">
            <!-- Modifications -->
            <tr>
                <td class="modifications-sectionheader" colspan="6">
                    &#160;Modifications since last build:&#160;
                    (<xsl:value-of select="count($modification.list)"/>)
                </td>
            </tr>

            <xsl:apply-templates select="$modification.list">
                <xsl:sort select="@dateOfSubmission" order="descending" data-type="text" />
            </xsl:apply-templates>

        </table>
    </xsl:template>

    <!-- Changelist template 
    <changelist type="p4" changelistNumber="15" user="non" client="non:all" dateOfSubmission="2002/05/02" />
    -->

    <xsl:template match="changelist">
        <tr valign="top">
            <xsl:if test="position() mod 2=0">
                <xsl:attribute name="class">changelists-oddrow</xsl:attribute>
            </xsl:if>
            <xsl:if test="position() mod 2!=0">
                <xsl:attribute name="class">changelists-evenrow</xsl:attribute>
            </xsl:if>

            <td class="modifications-data">
                <xsl:value-of select="@type"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="@changelistNumber"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="@user"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="@client"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="@dateOfSubmission"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="description"/>
            </td>
        </tr>
        <xsl:if test="count(affectedfile) > 0">
            <tr valign="top">
                <xsl:if test="position() mod 2=0">
                    <xsl:attribute name="class">changelists-oddrow</xsl:attribute>
                </xsl:if>
                <xsl:if test="position() mod 2!=0">
                    <xsl:attribute name="class">changelists-evenrow</xsl:attribute>
                </xsl:if>
                <td class="modifications-data" colspan="6">
                    <table align="right" cellpadding="1" cellspacing="0" border="0" width="95%">
                        <tr>
                            <td class="changelists-file-header" colspan="3">
                                &#160;Files affected by this changelist:&#160;
                                (<xsl:value-of select="count(affectedfile)"/>)
                            </td>
                        </tr>
                        <xsl:apply-templates select="affectedfile"/>
                    </table>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="affectedfile">
        <tr valign="top" >
            <xsl:if test="position() mod 2=0">
                <xsl:attribute name="class">changelists-file-oddrow</xsl:attribute>
            </xsl:if>
            <xsl:if test="position() mod 2!=0">
                <xsl:attribute name="class">changelists-file-evenrow</xsl:attribute>
            </xsl:if>

            <td class="changelists-file-spacer">
                &#160;
            </td>

            <td class="modifications-data">
                <b>
                    <xsl:value-of select="@action"/>
                </b>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="@filename"/>&#160;                
                <xsl:value-of select="@revision"/>
            </td>
        </tr>
    </xsl:template>
    
    <!-- Modifications template -->
    <xsl:template match="modification">
        <tr>
            <xsl:if test="position() mod 2=0">
                <xsl:attribute name="class">modifications-oddrow</xsl:attribute>
            </xsl:if>
            <xsl:if test="position() mod 2!=0">
                <xsl:attribute name="class">modifications-evenrow</xsl:attribute>
            </xsl:if>

            <td class="modifications-data">
                <xsl:value-of select="@type"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="user"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="project"/>
                <xsl:value-of select="filename"/>
            </td>
            <td class="modifications-data">
                <xsl:value-of select="comment"/>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
