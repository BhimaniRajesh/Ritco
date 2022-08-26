<%@ Page Language="C#" AutoEventWireup="true" CodeFile="STax_Vendor_Popup.aspx.cs" Inherits="GUI_UNI_MIS_TDS_STMT_TDS_Vendor_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vendor</title>
     <link id="Link1" href="../../images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
     
     <script language="javascript" type="text/javascript">
        
            function ConvertToUpper(objCustomer)
            {
                if(document.getElementById(objCustomer.id))
                {
                    if(document.getElementById(objCustomer.id).value != "")
                    {
                        document.getElementById(objCustomer.id).value = document.getElementById(objCustomer.id).value.toUpperCase()
                    }
                }
            }
            
            function ManageCustomerCodeName()
            {
                ConvertToUpper(document.getElementById("txtVendorName"))
            
                //Check for Customer Code entry
                if(document.getElementById("txtVendorCode"))
                {
                    if(document.getElementById("txtVendorCode").value != "")
                    {
                        if(document.getElementById("txtVendorName"))
                        {
                            document.getElementById("txtVendorName").value = ""
                        }
                    }
                }
                
                //Check for Customer Name entry
                if(document.getElementById("txtVendorName"))
                {
                    if(document.getElementById("txtVendorName").value != "")
                    {
                        if(document.getElementById("txtVendorCode"))
                        {
                            document.getElementById("txtVendorCode").value = ""
                        }
                    }
                }
            }
            
            function SelectCustomer(objCustomer)
            {
                var mQSParam = "<%=byteQSParam %>"
                
                if(mQSParam == 13)
                {
                    window.opener.document.forms[0].txtPartyCode.value = objCustomer.value
                }
                
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                var mSelectedControlName = objCustomer.name;
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptCustomer$ctl" + "0" + i + "$"
                    }
                    else
                    {
                        mDerivedControlName = "rptCustomer$ctl" + i + "$"
                    }
                    
                    //Match the selected control name with derived control name
                    if (mSelectedControlName != mDerivedControlName)
                    {
                        //If different then, de-select the radio button
                        if(document.getElementById(mDerivedControlName))
                        {
                            document.getElementById(mDerivedControlName).checked = false;
                        }
                    }
                }
            }

        </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="1" width="99%">
            <tr>
                <td align="left" style="height: 32px">
                    <span style="font-size: 8pt"><span style="font-family: Verdana">
                        <label id="lblNoteBU" class="blackfnt">
                            <b><u>Note: </u></b>
                        </label>
                        <br />
                        <label id="lblNote" class="blackfnt">
                            - For All Vendor list,keep blank both the input box.<strong> </strong>
                        </label>
                    </span></span>
                </td>
            </tr>
        </table>
    
    </div>
        <br />
        <table border="1" cellpadding="2" cellspacing="1" width="85%">
            <tr class="bgbluegrey">
                <td align="center" colspan="2" style="height: 20px">
                    <label id="lblParameter" class="blackfnt">
                        <span style="font-size: 8pt; font-family: Verdana">Search by parameter </span>
                    </label>
                </td>
            </tr>
            <tr style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                <td align="left">
                    <label id="lblCustCode" class="blackfnt">
                        Vendor Code
                    </label>
                </td>
                <td align="left">
                    &nbsp;
                    <input id="txtVendorCode" runat="server" class="inp" onblur="ConvertToUpper(this)"
                        type="text" />
                </td>
            </tr>
            <tr>
                <td align="left">
                    <label id="lblCustName" class="blackfnt">
                        <span style="font-size: 8pt; font-family: Verdana">Vendor Name </span>
                    </label>
                </td>
                <td align="left" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    &nbsp;
                    <input id="txtVendorName" runat="server" class="inp" onblur="ManageCustomerCodeName()"
                        type="text" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_OnClick" Text="Submit" />
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="0" cellspacing="1" width="99%">
            <tr>
                <td align="left">
                    <span style="font-size: 8pt"><span style="font-family: Verdana">
                        <label id="lblSelCustomerNoteBU" class="blackfnt">
                            <b><u>Note: </u></b>
                        </label>
                        <br />
                        <label id="lblSelCustomerNote" class="blackfnt">
                            - Click on radio buton to select Vendor.
                        </label>
                    </span></span>
                </td>
            </tr>
        </table>
        <br />
        <table border="1" cellspacing="1" class="boxbg" width="100%">
            <tr class="bgbluegrey">
                <td style="width: 10%">
                    &nbsp;
                </td>
                <td align="left" style="width: 30%">
                    &nbsp;<label id="lblCustCodeColHeader" class="blackfnt"><span style="font-size: 8pt;
                        font-family: Verdana">Vendor Code </span>
                    </label>
                </td>
                <td align="left" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
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
                            <%--<input id="radSelCustomer" type="radio" value="<%#DataBinder.Eval(Container.DataItem, "CustCode")%>" onclick="Done(this);"  runat="server"/>--%>
                            <input id="radSelBranch" runat="server" onclick="SelectCustomer(this);" type="radio"
                                value='<%#DataBinder.Eval(Container.DataItem, "VendorCode")%>' />
                        </td>
                        <td align="left" style="width: 30%">
                            <label id="lblRptCustCode1" class="blackfnt">
                                &nbsp;
                                <%#DataBinder.Eval(Container.DataItem, "VendorCode")%>
                            </label>
                        </td>
                        <td align="left">
                            <label id="lblRptCustName1" class="blackfnt">
                                &nbsp;
                                <%#DataBinder.Eval(Container.DataItem, "VendorName")%>
                            </label>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </form>
</body>
</html>
