<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupVendor.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_PopupVendor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
 <head id="Head1" runat="server">
        <title>
            Vendor Code
        </title>
        <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
        <%--<link id="Link1" href="../../../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />--%>

        <script language="javascript" type="text/javascript">
        
            function Child(obj)
            {
	            var Str = obj.value;
	        
	            window.opener.document.aspnetForm.ctl00$MyCPH1$txtVendorCode.value=Str;
	        
                window.close(); 
            }

        </script>
       
    </head>
<body>
    <form id="frmCustomerList" runat="server">
        <center>
            <table border="0" width="99%" cellspacing="1" cellpadding="0">
            <tr>
                <td align="left" style="height: 32px">
                        <label id="lblNoteBU" class="blackfnt">
                            <b><u>Note:</u></b>
                        </label>
                        <br />
                        <label id="lblNote" class="blackfnt">
                            - For All Customer list,keep blank both the input box.
                        </label>
                </td>
            </tr>
            </table>
            <br />
            <table border="1" width="85%" cellspacing="1" cellpadding="2">
                <tr class="bgbluegrey">
                    <td colspan="2" align="center" style="height: 20px">
                        <label id="lblParameter" class="blackfnt">
                            Search by parameter
                        </label>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <label id="lblCustCode" class="blackfnt">
                            Vendor Code
                        </label>
                    </td>
                    
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtVendorCode" runat="server" class="inp"/>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <label id="lblCustName" class="blackfnt">
                            Vendor Name
                        </label>
                    </td>
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtVendorName" runat="server" class="inp"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnSubmit" Text="Submit" OnClick="btnSubmit_OnClick" runat="server"/>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" width="99%" cellspacing="1" cellpadding="0">
                <tr>
                    <td align="left">
                        <label id="lblSelCustomerNoteBU" class="blackfnt">
                            <b><u>Note:</u></b>
                        </label>
                        <br />
                        <label id="lblSelCustomerNote" class="blackfnt">
                            - Click on radio buton to select Vendor.
                        </label>
                    </td>
                </tr>
            </table>
            <br />            
            <table border="0" width="100%" cellspacing="1" cellpadding="0">
            <tr>
                <td>
                    <table border="0" width="90%" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td width="10%" align="left"></td>
                            <td width="30%" align="left"><font class="blackfnt">&nbsp;Vendor Code</font></td>
                            <td align="left">
                                <font class="blackfnt">&nbsp;Vendor Name</font>
                                <asp:HiddenField ID="hdnqstr" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <asp:DataList ID="DataList1" runat="server" width="90%">
                        <ItemTemplate>
                            <table width="100%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                                <tr>
                                    <td width="10%" bgcolor="white" align="left">&nbsp;<input name="chk" type="radio" onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"vendorcode") %>' ></td>
                                    <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "vendorcode")%></font></td>
                                    <td bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "vendorname")%></font></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
            </table>
            
            <%--<table border="1" width="100%" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td style="width: 10%">
                        &nbsp;
                    </td>
                    
                    <td style="width: 30%" align="left">
                        &nbsp;<label id="lblCustCodeColHeader" class="blackfnt">Vendor Code
                        </label>
                    </td>
                    <td align="left">
                        &nbsp;
                        <label id="lblCustNameColHeader" class="blackfnt">
                            Vendor Name
                        </label>
                    </td>
                </tr>
                
                <asp:Repeater ID="rptCustomer" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <%--<input id="radSelCustomer" type="radio" value="<%#DataBinder.Eval(Container.DataItem, "CustCode")%>" onclick="Done(this);"  runat="server"/>--
                                <input id="radSelBranch" type="radio" value='<%# DataBinder.Eval(Container.DataItem, "vendorcode")%>' onclick="SelectCustomer(this);" runat="server" />

                            </td>
                            
                            <td style="width: 30%" align="left">
                                <label id="lblRptCustCode1" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "vendorcode")%>
                                </label>
                            </td>
                            
                            <td align="left">
                                <label id="lblRptCustName1" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "vendorname")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>--%>
            </center>            
        </form>
    </body>
</html>


