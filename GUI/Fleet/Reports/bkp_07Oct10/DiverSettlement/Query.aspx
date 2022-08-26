<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TripsheetQueryNew" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script src="../../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
     <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
  <script language="javascript" type="text/javascript">
   
    function nwOpen1(mNo)
        {
            window.open("Popup-Vehicle.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
              function nwOpen3(mNo)
        {
            window.open("Popup-Driver1.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
              function nwOpen4(mNo)
        {
            window.open("Popup_ManualNo.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
              function nwOpen5(mNo)
        {
            window.open("Popup_TripsheetNo.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
        
        
        
        
        
        
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Driver Settlement Report</asp:Label>
              <%--  <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align="right">
               <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
          
          
         
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                       
                      
                        <tr style="background-color: white">
                            <td align="right" valign="center" style="width: 250px">
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Tripsheet </asp:Label><asp:DropDownList ID="ddlDate"   runat="server" Width="80px" >
                                </asp:DropDownList>
                                <asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="True">Date Range</asp:Label>
                                </td>
                               <td align="left">
                                <Date:DT ID = "DT" runat="server" />
                            </td>
                        </tr>
                        
                        <tr   class="bgbluegrey">
                            <td align="center"  colspan="4">
                                <asp:Label ID="lblheading2"  CssClass="blackfnt" Font-Bold="true"   runat="server" Text="Select Request Status" ></asp:Label>
                                
                     
                              </td>
                           
                        </tr>
                          <tr   style="background-color: white" align="center">
                                <td   align="right" colspan="1" style="width: 250px"  >
                                    <asp:Label ID="Label4" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Branch   

                                    </asp:Label>
                                </td>
                                
                                <td align="left" colspan="3" ><asp:UpdatePanel ID="up3" runat="server">
                                                            <ContentTemplate>
                                                                &nbsp;
                             
                                      <asp:DropDownList ID="ddlro" AutoPostBack="true"   runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged"    >
                                      
                                     </asp:DropDownList> 
                                     </ContentTemplate>
                                     </asp:UpdatePanel></td>
                            </tr>
                        
                        
                        
                        
                        
                         <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px">
                                 <asp:Label ID="lblStatus" runat="server" Text="Status"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3">
                               &nbsp;   <asp:DropDownList ID="ddlStatus" runat="server">
                                      <asp:ListItem Selected="true">Both</asp:ListItem>
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Completed</asp:ListItem>
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                        
                            <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px">
                                 <asp:Label ID="Label1" runat="server" Text="Driverwise"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3">
                                &nbsp;   <asp:TextBox ID="txtDriver1"   AutoPostBack="true" CssClass="input"  runat="server"  OnTextChanged="RetrieveDriverDataInfo1"     ></asp:TextBox>
                    <asp:Label ID="Label9"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                                Width="14px"></asp:Label>
                                   <asp:Label ID="lblD1Error"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                                </td>
                             
                        </tr>
                        	   
                        
                   

                       </table>
                       
                        
                    
                    
                    
                    
                   </td>
            </tr>
        </table>
      <br/>
                       
                           <table cellspacing="1" style="width: 100%" align="center">
                        <tr style="background-color: white">
                            <td colspan="3" align="center">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShow" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShow_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
   
</asp:Content> 