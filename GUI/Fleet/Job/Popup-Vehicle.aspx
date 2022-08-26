<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Popup-Vehicle.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_Popup_Vehicle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="../../images/style.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Vehicle list</title>
    <script type="text/javascript" language="javascript" src="../../Js/querystring.js">
    </script>
    <script language="javascript" type="text/javascript">

        function SelectLocation(objLocation) {
            var qs = new Querystring();
            var mNo = qs.get("Mno");
            //alert(mNo)
            if (mNo == 1) {
                //alert(window.opener.document.forms[0].ctl00$MyCPH1$txtVehicleNo.value)
                window.opener.document.forms[0].ctl00$MyCPH1$txtVehicleNo.value = objLocation.value;
                window.opener.document.forms[0].ctl00$MyCPH1$txtVehicleNo.focus();
            }
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%--<center>
            <table border="0" cellspacing="1" cellpadding="0" style="width: 41%">
                <tr>
                    <td>
                        <font class="blackfnt"><b><u>Note:</u></b>
                            <br />
                            - Please enter Vehicle Number start with 'S' as 'S'
                            <%--<br />- Please enter Customer Name start with 'S' as 'S'--%>
        <%--<br />- For All customers list,keep blank both the input box.--%>
        </font> </td> </tr> </table>
        <br />
        <table border="1" cellspacing="1" cellpadding="2" width="80%">
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <font class="blackfnt">Search by parameter</font>
                </td>
            </tr>
            <tr>
                <td nowrap>
                    <font class="blackfnt">Own Vehicle Number</font>
                    <asp:HiddenField ID="hf_Vehicle_Attached_TS" runat="server" />
                    <asp:HiddenField ID="hf_Vehicle_Attached_JS" runat="server" />
                </td>
                <td>
                    <font class="blackfnt"><b>
                        <asp:TextBox ID="txtVehNo" runat="server"></asp:TextBox></b></font>
                </td>
            </tr>
            <tr>
                <td nowrap>
                    <font class="blackfnt">Status</font>
                </td>
                <td>
                    <font class="blackfnt"><b>
                        <table>
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="rbStatus" RepeatDirection="Horizontal" runat="server">
                                        <asp:ListItem Text="Tripsheet" Value="TS" Selected="True" />
                                        <asp:ListItem Text="Jobsheet" Value="JS" />
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlVehicleStatus" runat="server">
                                        <asp:ListItem Text="All" Value="" />
                                        <asp:ListItem Text="Available" Value="Available" />
                                        <asp:ListItem Text="In Transit" Value="In Transit" />
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </b></font>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                    <asp:Label ID="Label1" runat="server" ForeColor="#FF8080"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <asp:DataList ID="DataList1" HeaderStyle-CssClass="dgHeaderStyle" runat="server"
            Width="100%" DataKeyField="Vehno" Font-Names="Verdana" Font-Size="8pt" OnItemDataBound="DataListItemEventHandler">
            <HeaderStyle CssClass="dgHeaderStyle"  />
            <HeaderTemplate>
                <table style="width: 100%" cellpadding="0" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td style="width: 10%">
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="VehicleNumber" runat="server" Text="Vehicle Number"></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="VehicleStatus" runat="server" Text="Vehicle Status"></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="TripsheetNumber" runat="server" Text="Tripsheet Number"></asp:Label>
                        </td>
                        <td style="width: 10%">
                            <asp:Label ID="JobsheetStatus" runat="server" Text="Job Order Status"></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="JobOrderNumber" runat="server" Text="Job Order Number"></asp:Label>
                        </td>
                    </tr>
                </table>
            </HeaderTemplate>
            <ItemTemplate>
                <table style="width: 100%" cellpadding="0" cellspacing="1" class="boxbg">
                    <tr style="background-color: white">
                        <td style="width: 10%">
                            <asp:RadioButton ID="rbtn" onclick="javascript:SelectLocation(this);" value='<%# Eval("Vehno") %>'  runat="server" />
                            
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="VehicleNumber" runat="server" Text='<%#Eval("Vehno")%>'></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="VehicleStatus" runat="server" Text='<%#Eval("Vehicle_Status")%>'></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="TripsheetNumber" runat="server" Text='<%#Eval("VslipNo")%>'></asp:Label>
                        </td>
                        <td style="width: 10%">
                            <asp:Label ID="JobsheetStatus" runat="server" Text='<%#Eval("JS_Maintainance_Status")%>'></asp:Label>
                        </td>
                        <td style="width: 20%">
                            <asp:Label ID="JobOrderNumber" runat="server" Text='<%#Eval("Job_Order_No")%>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
    </div>
    </form>
</body>
</html>
