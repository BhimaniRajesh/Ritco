<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="FollowDetail.aspx.cs" Inherits="Reports_FollowDetail" %>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <script language="javascript" src="../../images/CommonJS.js" type="text/javascript" ></script>
         <link id="Link1" href="../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
       <%--   <link href="~/Entry/Order/Tabs.css" rel="stylesheet" type="text/css" />--%>
 
</head>
<body>

    <atlas:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
   <form id="form1" runat="server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
              <%--  <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Module  > Reports > Request Follow-Up  Report > Details</asp:Label>--%>
              <%--  <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
   <%-- <hr align="center" size="1" color="#8ba0e5">--%>
      <br> 
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="center">
                <asp:Label ID="lblHeading" CssClass="blackfnt" Font-Bold="true" Font-Underline="true" Font-Size="12"  runat="server"></asp:Label>&nbsp;
            <%-- //   <hr align="center" size="1" color="#8ba0e5"> --%>
                                           
          </td>      
        </tr>
    </table>
      <br/> 
  <%--  <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="center">
                        
        <asp:Button ID="Button1"  runat="server" Text="Back" OnClick="Button1_Click" />
            <%-- //   <hr align="center" size="1" color="#8ba0e5">
                                           
          </td>      
        </tr>
    </table>--%>
    

<br />
 <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                &nbsp;<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="50"  OnPageIndexChanging="pgChange" >
                              <Columns>
                                <asp:BoundField DataField="Request_Id" HeaderText="Request ID">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Request_By" HeaderText="Request  By">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Request_Dt" HeaderText="Request Date">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                             
                                
                         <%-- <asp:BoundField DataField="RequestNo" HeaderText="Customer">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>--%>
                      <asp:BoundField DataField="RouteCode" HeaderText="Route Code">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField> 
                                <asp:BoundField DataField="Start_date_time" HeaderText="Start Date  & Time"  />
                                <asp:BoundField DataField="End_dt_tm" HeaderText="End Date & Time"   /> 
                              
                                   <%--<asp:BoundField DataField="No_Passenger" HeaderText="No.Of Passanger"  />--%>
                                <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type"   />
                          <asp:BoundField DataField="status" HeaderText="Status"   />
   
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <br/>
                        
                         <p align="center">
  <table >
  <tr  align="center" style="background-color: white">
  <td align="center" style="height: 21px">
    <asp:LinkButton ID="LinkButton1" Font-Bold="true" runat="server"  Visible="false" OnClick="LinkButton1_Click">Transform To XLS</asp:LinkButton>
  </td>
        </tr>
  </table>
  </p> 
                        
                    </ContentTemplate>
                 
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>

<%--</asp:Content>--%>
   </form>
</body>
</html>
