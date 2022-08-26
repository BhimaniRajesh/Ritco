<%@ Page Language="C#" AutoEventWireup="true"    CodeFile="frmTripSheetDetails.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmTripSheetDetails" %>

<%-- <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">--%>
    
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Tripsheet Journey Details</title>
  <%--  <script language="javascript" src="../../images/CommonJS.js" type="text/javascript" ></script>--%>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
       <%--   <link href="~/Entry/Order/Tabs.css" rel="stylesheet" type="text/css" />--%>
 
</head>
<body>

    <asp:ScriptManager  ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
   <form id="form1" runat="server">

    
    <script language="javascript">
 
// function ViewPrint(tReqId)
// {
//    
//  	var strurl="frmTripSheetDetails.aspx?strVSlipNo=" + strVSlipNo    //+ "&PrintMode=" + tPrintMode  
//     popup = window.open(strurl,"","height=475,width=850,scrollbars=yes,left=100,top=125");
// }
// 

</script>


<%--<%
    string tReqId = "";
    tReqId = Request.QueryString["strVSlipNo"];
   //lblDocNoVal.Text = ReqId;
 %>
    --%>
    
    
    
    
    
    
    
    
    
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true"   runat="server">TripSheet Journey Details</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            
             <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>
            
         
          </td>      
        </tr>
    </table>
      <hr align="center" size="1" color="#8ba0e5">
      <br/>
      <br/>
       <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
        <asp:GridView ID="GridView1" runat="server"   
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            >
                              <Columns>
                                <asp:BoundField DataField="thcno" HeaderText="THC.No">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="thcdt1" HeaderText="THC Date">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="route" HeaderText="Route Name">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                             
                                

                               <%--  <asp:BoundField DataField="OPENKM" HeaderText="Open Km">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField> --%>
                                <asp:BoundField DataField="ld_tc" HeaderText="No.Of Manifests"  />
                                <asp:BoundField DataField="TotKm" HeaderText="Total Km"   /> 
                              
<%--                                   <asp:BoundField DataField="No_Passenger" HeaderText="No.Of Passanger"  />
                                <asp:BoundField DataField="VehicleType" HeaderText="Vehicle Type"   />
                          <asp:BoundField DataField="status" HeaderText="Status"   />--%>
   
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
      
                   </td>
                   </tr>
                   </table>
      
      
      
      
      
      
      
<%--      </asp:Content> --%>


    </form>
</body>
</html>