<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillingParty_Popup.aspx.cs" Inherits="BillingParty_Popup" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>
            Customer List
        </title>
        
        <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" runat="server" />
        
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
                ConvertToUpper(document.getElementById("txtCustName"))
            
                //Check for Customer Code entry
                if(document.getElementById("txtCustCode"))
                {
                    if(document.getElementById("txtCustCode").value != "")
                    {
                        if(document.getElementById("txtCustName"))
                        {
                            document.getElementById("txtCustName").value = ""
                        }
                    }
                }
                
                //Check for Customer Name entry
                if(document.getElementById("txtCustName"))
                {
                    if(document.getElementById("txtCustName").value != "")
                    {
                        if(document.getElementById("txtCustCode"))
                        {
                            document.getElementById("txtCustCode").value = ""
                        }
                    }
                }
            }
            
            function SelectCustomer(objCustomer)
            {
                var mQSParam = "<%=byteQSParam %>"
                
                if(mQSParam == 13)
                {
                    window.opener.document.getElementById("ctl00_MyCPH1_txtPartyCode").value = objCustomer.value
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

        <form id="frmCustomerList" runat="server">
            
            
            <center>
            
            <table border="0" width="99%" cellspacing="1" cellpadding="0">
                <tr>
                    <td align="left">
                        <label id="lblNoteBU" class="blackfnt">
                            <b>
                                <u>
                                    Note:         
                                </u>
                            </b>
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
                    <td colspan="2" align="center">
                        <label id="lblParameter" class="blackfnt">
                            Search by parameter
                        </label>
                    </td>
                </tr>
                
                <tr>
                    <td align="left">
                        <label id="lblCustCode" class="blackfnt">
                            Customer Code
                        </label>
                    </td>
                    
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtCustCode" runat="server" onblur= "ConvertToUpper(this)" class="inp"/>
                    </td>
                </tr>
                
                <tr>
                    <td align="left">
                        <label id="lblCustName" class="blackfnt">
                            Customer Name
                        </label>
                    </td>
                    
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtCustName" runat="server" onblur= "ManageCustomerCodeName()" class="inp"/>
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
                            <b>
                                <u>
                                    Note: 
                                </u>
                            </b>
                        </label>
                        <br />
                        <label id="lblSelCustomerNote" class="blackfnt">
                            - Click on radio buton to select Customer.
                        </label>
                    </td>
                </tr>
            </table>
            
            <br />

            <table border="1" width="100%" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td style="width: 10%">
                        &nbsp;
                    </td>
                    
                    <td style="width: 30%" align="left">
                        <label id="lblCustCodeColHeader" class="blackfnt">
                            Customer Code
                        </label>
                    </td>
                    <td align="left">
                        <label id="lblCustNameColHeader" class="blackfnt">
                            Customer Name
                        </label>
                    </td>
                </tr>
                
                <asp:Repeater ID="rptCustomer" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <input id="radSelCustomer" type="radio" value='<%#DataBinder.Eval(Container.DataItem, "CustCode")%>' onclick="SelectCustomer(this)" runat="server" />
                            </td>
                            
                            <td style="width: 30%" align="left">
                                <label id="lblRptCustCode" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "CustCode")%>
                                </label>
                            </td>
                            
                            <td align="left">
                                <label id="lblRptCustName" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "CustName")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
                       
            </center>
            
        </form>

    </body>

</html>
