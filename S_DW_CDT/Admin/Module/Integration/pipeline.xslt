<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:variable name="DropZoneCounter" select="0" />
  
  <!--
  <HTML>
  -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="/toolbox">
    <table border="0" width="209" cellpadding="0" cellspacing="0">
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="/toolbox/toolbox-group">
    <tr>
      <td valign="top">
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
          <tr>
          <td class="toolbar-header">
            <xsl:attribute name="onclick">
              (document.getElementById('<xsl:value-of select="@name"/>').style.display == 'none') ? document.getElementById('<xsl:value-of select="@name"/>').style.display = '' : document.getElementById('<xsl:value-of select="@name"/>').style.display = 'none';
            </xsl:attribute>
            <b>
              <nobr>
                <xsl:value-of select="@name"/>
              </nobr>
            </b>
          </td>
        </tr>
      </table>
      <table border="0">
        <xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
        <xsl:apply-templates/>
      </table>
    </td>
  </tr>
</xsl:template>


  <xsl:template match="/toolbox/toolbox-group/toolbox-item">
      <tr>
        <td>
          <div class="designer-toolbox-item" dragable="true" dragaction="insert">
            <xsl:attribute name="activitytype"><xsl:value-of select="@type"/></xsl:attribute>
            <xsl:attribute name="id"><xsl:value-of select="@type"/></xsl:attribute>
            <xsl:attribute name="inputformat"><xsl:value-of select="@inputformat"/></xsl:attribute>
            <xsl:attribute name="outputformat"><xsl:value-of select="@outputformat"/></xsl:attribute>

            <table width="100%" class="toolboxitem_default" onmousemove="toolboxitem(this,'hover');" onmouseout="toolboxitem(this,'default');">
              <tr>
                <td align="left" width="35">
                  <image align="left" valign="abstop">
                    <xsl:attribute name="src">
                      <xsl:if test="@image = ''">/Admin/Module/Integration/Images/activity.png</xsl:if>
                      <xsl:if test="@image!= ''"><xsl:value-of select="@image"/></xsl:if>
                    </xsl:attribute>
                  </image>
                </td>
                <td>
                  <xsl:value-of select="@name"/>
                </td>
              </tr>
              </table>
              
          </div>
        </td>
      </tr>
  </xsl:template>

  <xsl:template match="/pipeline">
    <div class="pipeline" onMouseout="HideActivityTip();">
      
      <xsl:if test="@lock = 'true'">
        <xsl:attribute name="style">
          filter:progid:DXImageTransform.Microsoft.Alpha(opacity=55);-moz-opacity: 0.4;
        </xsl:attribute>
        <br />
        <font color="red">
          <xsl:value-of select="@locktitle"/>
        </font>

        <image id="lockmenubuttons" border="0" src="/x.gif">
          <xsl:attribute name="onload">
            DisableMenuButtons();
          </xsl:attribute>
        </image>
      </xsl:if>      
      
      <p><br/></p>
      <div class="pipeline-title"><xsl:value-of select="@title"/></div>
      <div class="pipeline-start"><br/></div>
      <xsl:apply-templates />
      <div class="pipeline-stop"></div>
    </div>
  </xsl:template>

  <xsl:template match="sequence">
    
    <div class="sequence" xstyle="border:1px solid red">

      <xsl:if test="count(activity) &gt; 0">
        <div class="arrow" dropzone="true">
          <xsl:if test="@locked = 'true'">
            <xsl:attribute name="dropzone">false</xsl:attribute>
          </xsl:if>

          <xsl:attribute name="sequence">
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:attribute name="activity-before"></xsl:attribute>
          <xsl:attribute name="activity-after"></xsl:attribute>
          <br/>
        </div>
      </xsl:if>

      <xsl:if test="count(activity) = 0">
        <div class="arrow-insert" dropzone="true">
          <xsl:if test="@locked = 'true'">
            <xsl:attribute name="dropzone">false</xsl:attribute>
          </xsl:if>

          <xsl:attribute name="sequence">
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:attribute name="activity-before"></xsl:attribute>
          <xsl:attribute name="activity-after"></xsl:attribute>
          <br/>
        </div>
      </xsl:if>

      <xsl:if test="count(activity) &gt; 0">
        <xsl:for-each select="activity">
          <xsl:apply-templates select="." mode="wrap">
            <xsl:with-param name="pos" select="position()"></xsl:with-param>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:if>
      
    </div>
  </xsl:template>

  <xsl:template match="activity" mode="wrap">
    <xsl:param name="pos" />
    <div class="activity">
      <xsl:apply-templates select="."/>
    </div>
    
    <div class="arrow" dropzone="true">
      <xsl:if test="@locked = 'true'">
        <xsl:attribute name="dropzone">false</xsl:attribute>
      </xsl:if>      
      
      <xsl:attribute name="sequence"><xsl:value-of select="../@id" /></xsl:attribute>
      <xsl:attribute name="activity-before"><xsl:value-of select="@id" /></xsl:attribute>
      <xsl:attribute name="activity-after"><xsl:value-of select="../activity[$pos+1]/attribute::id" /></xsl:attribute>
      <br/>
    </div>
    
  </xsl:template>

  <xsl:attribute-set name="activity-attr">
    <xsl:attribute name="activitytype"><xsl:value-of select="@type"/></xsl:attribute>
    <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    <xsl:attribute name="onclick">event.cancelBubble=true;DesignerSelectActivity('<xsl:value-of select="@id"/>');</xsl:attribute>
    <xsl:attribute name="oncontextmenu">event.cancelBubble=true;PopupProperties('<xsl:value-of select="@id"/>');return false;</xsl:attribute>
    <xsl:attribute name="dragable">true</xsl:attribute>
    <xsl:attribute name="dragaction">move</xsl:attribute>
    <xsl:attribute name="inputformat"><xsl:value-of select="@inputformat"/></xsl:attribute>
    <xsl:attribute name="outputformat"><xsl:value-of select="@outputformat"/></xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:template match="activity">
    <table width="100%" height="100%" class="activity-default" xsl:use-attribute-sets="activity-attr" onMouseout="HideActivityTip();">

      <xsl:if test="@locked = 'true'">
        <xsl:attribute name="dragable">false</xsl:attribute>
        <xsl:attribute name="dragaction"></xsl:attribute>
      </xsl:if>
     
      <xsl:attribute name="onmouseover">
        ActivityTip(event, '<xsl:value-of select="@description"/>');
      </xsl:attribute>
      <xsl:if test="@select = 'true'">
        <xsl:attribute name="class">activity-default-selected</xsl:attribute>
      </xsl:if>
      
      <tr>
        <td class="activity-text" align="center" valign="middle" style="width:30px;height:30px;">
          <image valign="abstop" border="0" style="width:24px;height:24px;">
            <xsl:attribute name="src">
              <xsl:if test="@image = ''">/Admin/Module/Integration/Images/activity.png</xsl:if>
              <xsl:if test="@image!= ''"><xsl:value-of select="@image"/></xsl:if>
            </xsl:attribute>
          </image>
        </td>
        <td class="activity-text" align="center" valign="middle">
          <xsl:value-of select="@title"/>
          <xsl:apply-templates />
        </td>        
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="activity[@type='3']">
    <table width="200" height="100" class="activity-type3" align="center" xsl:use-attribute-sets="activity-attr">
      <xsl:if test="@select = 'true'">
        <xsl:attribute name="class">activity-type3-selected</xsl:attribute>
      </xsl:if>
      <tr>
        <td align="center" valign="top" class="activity-type3-sequence">
          <div class="activity-type3-sequence-1"><xsl:apply-templates select="sequence[1]"/></div>
        </td>
        <td align="center" valign="top" class="activity-type3-sequence">
          <div class="activity-type3-sequence-2"><xsl:apply-templates select="sequence[2]"/></div>
        </td>
      </tr>
    </table>
  </xsl:template>
  
</xsl:stylesheet> 
