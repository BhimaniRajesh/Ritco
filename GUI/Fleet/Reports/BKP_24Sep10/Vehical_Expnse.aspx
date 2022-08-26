<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Vehical_Expnse.aspx.cs" Inherits="Report_Vehical_Expnse" %>


<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
  <script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>
<script src="../../images/DateControl.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>
  <script language="javascript">
  
        function nwOpen()
        {
            window.open("Popup-Vehicle.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
         var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
         
         </script>
         <asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Vehicle Expenes Register</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    
 <table cellspacing="1" style="width: 800px">
        <tr>
            <td>
            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" 
                    runat="server">
                <ContentTemplate>
                <table cellspacing="1" style="width: 100%" class="boxbg">
                    
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                   
                  <tr style="background-color: white"> 
                        <td align="left" valign="center" width="23%" >
                            <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">License Expiry Date</asp:Label></td>
                        <td align="left" colspan="1" width="77%" >
                            <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                        </td>
                    </tr>
                      <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Width="150px">Select Branch :</asp:Label></td>
                        <td align="left" style="width: 123%;">
                           <asp:DropDownList ID ="ddlBranch"  runat="server" Width="150px" ></asp:DropDownList> 
                         </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Width="150px">Vehicle Name :</asp:Label></td>
                        <td align="left" style="width: 123%;">
                            <asp:TextBox ID="txtvehicle" runat="server" CssClass="Input" Width="129px"></asp:TextBox><input id="Vehno" runat="server"   type="button" value="..." onclick="javascript:nwOpen('Popup-Vehicle.aspx',null,'height=250,width=300,left=350,top=200,status=no,resizable=no,scrollbars=yes,toolbar=no,location=no,menubar=no');"  />
                            
                           </td>
                    </tr>
                    
                   

   <tr style="background-color: white">
                        <td colspan="2" align="right" style="width: 100%">
                           <asp:UpdatePanel ID="UPShowCustomer" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                 <asp:Button ID="btnShow" runat="server" Text="Submit" ValidationGroup="VGDtFromTo" OnClick="btnShow_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        
            </td>
        </tr>
       
    </table>
    <br>
   

    
 
 </asp:Content>
