<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmCCodePopUp.aspx.cs" Inherits="FrmCCodePopUp"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
  <link id="Link1" href="../../images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
<head runat="server">
    <title>Untitled Page</title>
    
    <script language ="javascript" type="text/javascript" >
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
                if(window.opener.document.getElementById("ctl00_MyCPH1_TextBox1"))
                {
                    window.opener.document.getElementById("ctl00_MyCPH1_TextBox1").value = objCustomer.value
                }
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                var mSelectedControlName = objCustomer.name;
                //alert(mSelectedControlName);
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
                            //document.getElementById(mDerivedControlName).parentElement.parentElement.className = document.getElementById(mDerivedControlName).parentElement.parentElement.orgClassName;
                            //document.getElementById(mDerivedControlName).style.backgroundColor = document.getElementById(mDerivedControlName).radioButtonBackColor;
                        }
                    }
                    else
                    {
                        //document.getElementById(mDerivedControlName).parentElement.parentElement.className = "trSelectedRow"
                        //document.getElementById(mDerivedControlName).style.backgroundColor = "#8ba0e5";
                    }
                }
            }    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center>
       
                
            <table border="0" cellpadding="0" cellspacing="1" width="99%">
                <tr>
                    <td align="left">
                        <label id="lblNoteBU" class="blackfnt">
                            <b><u>Note: </u></b>
                        </label>
                        <br />
                        <label id="lblNote" class="blackfnt">
                            - For All Customer list,keep blank both the input box.
                        </label>
                    </td>
                </tr>
            </table>
            <%-- <table border="1" width="85%" cellspacing="1" cellpadding="2">
                <tr class="bgbluegrey">
                    <td colspan="2" align="center" style="height: 20px">
                        <label id="Label1" class="blackfnt">
                            Search by parameter
                        </label>
                    </td>
                </tr>--%>
            <br />
            <table border="1" cellpadding="2" cellspacing="1" width="85%">
                <tr class="bgbluegrey">
                    <td align="center" colspan="2" class="blackbnt"  >
                        <label id="lblParameter" class="blackfnt">
                            Search by parameter
                        </label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" style="height: 30px" class="blackbnt">
                        <label id="lblCustCode" class="blackfnt">
                            Customer Code
                        </label>
                    </td>
                    <td align="left" class="blackbnt" style="height: 30px">
                        &nbsp;
                        <input id="txtCustCode" runat="server" class="inp" 
                            type="text" />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackbnt">
                        <label id="lblCustName" class="blackfnt">
                            Customer Name
                        </label>
                    </td>
                    <td align="left" class="blacskbnt">
                        &nbsp;
                        <input id="txtCustName" runat="server" class="inp" onblur="ManageCustomerCodeName()"
                            type="text" />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center" colspan="2" class="blackbnt">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="0" cellspacing="1" width="99%">
                <tr>
                    <td class="blackfnt"  align="left">
                        <label id="lblSelCustomerNoteBU" class="blackfnt">
                            <b><u>Note: </u></b>
                        </label>
                        <br />
                        <label id="lblSelCustomerNote" class="blackfnt">
                            - Click on radio buton to select Customer.
                        </label>
                    </td>
                </tr>
            </table>
            <br />
            <table border="1" cellspacing="1" class="boxbg" width="100%">
                <tr class="bgbluegrey">
                    <td style="width: 10%" class="blackbnt">
                        &nbsp;
                    </td>
                    <td align="left" style="width: 30%" class="blackbnt">
                        &nbsp;
                        <label id="lblCustCodeColHeader" class="blackfnt">
                            Customer Code
                        </label>
                    </td>
                    <td align="left" class="blackbnt">
                        &nbsp;
                        <label id="lblCustNameColHeader" class="blackfnt">
                            Customer Name
                        </label>
                    </td>
                </tr>
                <asp:Repeater ID="rptCustomer" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <%--class="trOddRow" orgClassName="trOddRow" style="background-color: White"--%>
                            <td style="width: 10%" class="blackbnt">
                                &nbsp;
                                <input id="radSelCustomer" runat="server" onclick="SelectCustomer(this)" radiobuttonbackcolor="White"
                                    style="background-color: White" type="radio" value='<%#DataBinder.Eval(Container.DataItem, "CustCode")%>' />
                            </td>
                            <td align="left" class="blackbnt" style="width: 30%">
                                <label id="lblRptCustCode" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "CustCode")%>
                                </label>
                            </td>
                            <td align="left" class="blackbnt">
                                <label id="lblRptCustName" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "CustName")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr style="background-color: White">
                            <%--class="trEvenRow" orgClassName="trEvenRow"--%>
                            <td style="width: 10%">
                                &nbsp;
                                <input id="radSelCustomer" runat="server" onclick="SelectCustomer(this)" radiobuttonbackcolor="#cccccc"
                                    type="radio" value='<%#DataBinder.Eval(Container.DataItem, "CustCode")%>' />
                                <%--style="background-color:#cccccc"--%>
                            </td>
                            <td align="left" style="width: 30%">
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
                    </AlternatingItemTemplate>
                </asp:Repeater>
            </table>
        </center>
    
    </div>
    </form>
</body>
</html>
