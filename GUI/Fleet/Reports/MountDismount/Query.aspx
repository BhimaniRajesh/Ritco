<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_MountDismount_Query" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script src="../../../images/commonJs.js"  language="javascript" type="text/javascript"></script>
<script src="../../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">  
     
 
        
</script>

<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
    cal.setCssPrefix("TEST");
    cal.showNavigationDropdowns();
     function OnSub_DATACHECK()
    {
      var txtDateFrom=document.getElementById("ctl00$MyCPH1$DT$txtDateFrom");
       var txtDateTo=document.getElementById("ctl00$MyCPH1$DT$txtDateTo");
            
      
       var ddlMode=document.getElementById("ctl00_MyCPH1_ddlMode");
        if (ddlMode.value =="0" ) 
        {    
        window.open("Result.aspx?FromDt=" + txtDateFrom.value + "&ToDt=" + txtDateTo.value + "&MODE=" + ddlMode.value + "");
        }
        else if (ddlMode.value =="M" )
        {    
        window.open("ResultMount.aspx?FromDt=" + txtDateFrom.value + "&ToDt=" + txtDateTo.value + "&MODE=" + ddlMode.value + "");
        }
        else  if (ddlMode.value =="DM" ) 
        {    
        window.open("ResultDismount.aspx?FromDt=" + txtDateFrom.value + "&ToDt=" + txtDateTo.value + "&MODE=" + ddlMode.value + "");
        }
    }
</script>

 <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
    layer-background-color: white; z-index: 99;">
</div>

<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Tyre Mount/Dismount Register</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
    
    <table cellspacing="1" cellpadding="2" style="width:700px" class="boxbg">
    
            <tr class="bgbluegrey">
                <td colspan="3" align="center">
                    <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                </td>
            </tr>
           
            <tr style="background-color: white">
                <td align="right" valign="center" style="width: 30%; text-align: left;">
                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Font-Bold="True">Date Range</asp:Label></td>
                <td align="left" colspan="2">
                <Date:DT ID="DT" EnableTillDate="false" runat="server" />
                </td>
            </tr> 
            <tr style="background-color: white">
                <td align="left" >
                   <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Mode Status</asp:Label></td>
                     <td align="left" style="width: 123%;" colspan="3">
                            <asp:DropDownList ID="ddlMode" runat="server" Width="229px">
                            <asp:ListItem Text="ALL" Value='0' ></asp:ListItem>
                            <asp:ListItem Text="Mount" Value="M"></asp:ListItem>
                                    <asp:ListItem Text="Dismount" Value="DM"></asp:ListItem>
                            </asp:DropDownList>
                         </td>
                    </tr>
            
              <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right">
                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                       <%-- <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> --%>
                        <asp:Button ID="btnShow" runat="server" Text="Submit"  OnClientClick="Javascript: return OnSub_DATACHECK();"    /> 
                    </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>

                       </table>
        
      <br/>

</asp:Content>