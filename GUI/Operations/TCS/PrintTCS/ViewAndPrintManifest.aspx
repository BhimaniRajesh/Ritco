<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewAndPrintManifest.aspx.cs" Inherits="GUI_Operations_TCS_PrintTCS_ViewAndPrintManifest" %>
<%@ OutputCache Location="None" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head id="Head1" runat="server">
    
        <title>
            View & Print Manifest
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
            
        <script language="javascript" type="text/javascript">
            
            function OpenInWindow(windURL, h, w, l, t)
            {
		        var winOpts = "scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
    		    
		        window.open(windURL, "", winOpts);
	        }
            
        </script>    

    </head>

    <body>
        
        <form id="frmManifest" runat="server">
            <div>
                <%--<table border="1" cellspacing="1" cellpadding="1"  width="100%">
                    <tr style="background-color: White">
                        <td style="width: 60%" valign="top">
                            <label class="blackfnt">
                                <label style="font-size: 3">
                                    <b>
                                    </b>
                                </label>
                                <label class="blackfnt">
                                    <label style="font-size: 3">
                                        <img border="0" src="../../../images/<%=Trim(Session("logofile"))%>" />
                                    </label>
                                </label>
                            </label>
                        </td>
                        
                        <td>
                            <table border="1" cellspacing="1" cellpadding="1" width="100%">
                                <tr style="background-color: White">
                                    <td style="width: 50%">
                                        <label class="blackfnt">
                                            LS No.:
                                        </label>
                                    </td>
                                    
                                    <td style="width: 50%">
                                        <label class="bluefnt">
                                            <b>
                                                <%=strLoadingSheetNo %>
                                            </b>
                                        </label> 
                                    </td>
                                </tr>
                                
                                <tr style="background-color: White">
                                    <td style="width: 50%">
                                        <label class="blackfnt">
                                            LS Date:
                                        </label>
                                    </td>
                                    
                                    <td style="width: 50%">
                                        <label class="bluefnt">
                                            <b>
                                                <%=strLoadingSheetDateAsItIs %>
                                            </b>
                                        </label> 
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td colspan="2">
                            <label class="blackfnt">
                                &nbsp;
                            </label>
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td style="width: 60%" valign="top">
                            <label class="blackfnt">
                                <label style="font-size: 3">
                                    <b>
                                        Manifest
                                    </b>
                                </label>
                            </label>
                        </td>
                        
                        <td style="width: 60%" valign="top">
                            <label class="blackfnt">
                                <b>
                                    LS Location:&nbsp;
                                </b>
                            </label>
                            <label class="bluefnt">
                                <%=strLoadingBranch %>
                            </label>
                        </td>
                    </tr>
                    
                    <!--4th Row-->
                    <tr style="background-color: White"> 
                        <td colspan="2" align="center">
                            <label class="blackfnt">
                                <b>
                                    Manifest Summary
                                </b>
                            </label>
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td colspan="2" align="center">
                            &nbsp;
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td colspan="2" align="center">
                            <table border="1" cellspacing="1" cellpadding="1" width="100%">
                                <tr style="background-color: White">
                                    <td style="width: 10%" align="left">
                                        <label class="blackfnt">
                                            Vehicle No.
                                        </label>
                                    </td>
                                    
                                    <td style="width: 23%" align="left">
                                        <label class="bluefnt">
                                            <%=strLoadingVehicle %>
                                        </label>
                                    </td>
                                    
                                    <td style="width: 10%" align="left">
                                        <label class="blackfnt">
                                            Route
                                        </label> 
                                    </td>
                                    
                                    <td align="left">
                                        <label class="bluefnt">
                                            <%=strLoadingRouteCode%>
                                        </label> 
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td colspan="2" align="center">
                            &nbsp;
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td colspan="2" align="center">
                            <table border="1" cellspacing="1" cellpadding="1" width="100%">
                                <tr style="background-color: White"> 
                                    <td style="width: 5%" align="center">
                                        <label class="blackfnt"> 
                                            Sr.No.
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 10%">
                                        <label class="blackfnt"> 
                                            Docket No.
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 10%">
                                        <label class="blackfnt"> 
                                            Booking Date
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 15%">
                                        <label class="blackfnt"> 
                                            Booking Location
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 15%">
                                        <label class="blackfnt"> 
                                            Consignor / Consignee
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 10%">
                                        <label class="blackfnt"> 
                                            Next Stop Location
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 15%">
                                        <label class="blackfnt"> 
                                            Delivery Location
                                        </label>
                                    </td>
                                    
                                    <td align="center" style="width: 15%">
                                        <label class="blackfnt"> 
                                            Delivery Date
                                        </label>
                                    </td>
                                    
                                    <td align="center">
                                        <label class="blackfnt">
                                            Packages
                                            <br />
                                            L/B
                                        </label>
                                    </td>
                                    
                                    <td align="center">
                                        <label class="blackfnt">
                                            Weight
                                            <br />
                                            L/B
                                        </label>
                                    </td>
                                </tr>
                                
                                <asp:Repeater ID="rptDocketList" runat="server">
                                    <ItemTemplate>
                                        <tr style="background-color: White">
                                            <td align="right">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "DocketDate")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "BookingLocation")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "ConsName")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "NextStop")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "DelyLoc")%>
                                                </label>
                                            </td>
                                            
                                            <td align="left">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "DelyDate")%>
                                                </label>
                                            </td>
                                            
                                            <td align="right">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "PackagesLB")%>
                                                </label>
                                            </td>
                                            
                                            <td align="right">
                                                <label class="bluefnt">
                                                    &nbsp;
                                                    <%#DataBinder.Eval(Container.DataItem, "WeightLB")%>
                                                </label>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="background-color: White"> 
                        <td colspan="2" align="center">
                            &nbsp;
                        </td>
                    </tr>
                    
                    <tr style="background-color: White">
                        <td colspan="2" align="center">
                            <table border="1" cellspacing="1" cellpadding="0" width="100%">
                                <!--1st Row-->
                                <tr style="background-color: White"> 
                                    <td style="width: 25%" align="center">
                                        <label class="blackfnt">
                                            Staff Name
                                        </label>
                                    </td>
                                    
                                    <td style="width: 25%" align="center">
                                        <label class="blackfnt">
                                            Sign
                                        </label>
                                    </td>
                                    
                                    <td style="width: 20%" align="center">
                                        <label class="blackfnt">
                                            Prepared By
                                        </label>
                                    </td>
                                    
                                    <td style="width: 10%" align="center">
                                        <label class="blackfnt">
                                            At
                                        </label> 
                                    </td>
                                    
                                    <td style="width: 20%" align="center">
                                        <label class="blackfnt">
                                            Date &amp; Time
                                        </label>
                                    </td>
                                </tr>
                                
                                <tr style="background-color: White"> 
                                    <td style="width: 25%" align="left">
                                        <label class="blackfnt">
                                            &nbsp;
                                        </label> 
                                    </td>
                                    
                                    <td style="width: 25%" align="left">
                                        <label class="blackfnt">
                                            &nbsp;
                                        </label> 
                                    </td>
                                    
                                    <td style="width: 20%" align="center">
                                        <label class="bluefnt">
                                            <%=strLoadingSheetPrepBy %>
                                        </label>
                                    </td>
                                    
                                    <td style="width: 10%" align="center">
                                        <label class="bluefnt">
                                            <%=strLoadingBranchCode %>
                                        </label>
                                    </td>
                                    
                                    <td style="width: 20%" align="center">
                                        <label class="bluefnt">
                                            <%=strLoadingSheetDateAsItIs %> : <%=strLoadingSheetTCDateInTimeFormat %>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                
                <br />
                
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td colspan="10" align="right">
                            <input type="button" id="btnPrint" value="Print" runat="server" />
                        </td>
                    </tr>
                </table>--%>
                                
            </div>
        </form>
    </body>
</html>
