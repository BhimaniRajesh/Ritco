<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupDriver.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_PopupCustomer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
 <head id="Head1" runat="server">
        <title>
            Driver Details
        </title>
     <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
        <%--<link id="Link1" href="../../../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />--%>

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
                ConvertToUpper(document.getElementById("txtDriverName"))
            
                //Check for Customer Code entry
                if(document.getElementById("txtDriverCode"))
                {
                    if(document.getElementById("txtDriverCode").value != "")
                    {
                        if(document.getElementById("txtDriverName"))
                        {
                            document.getElementById("txtDriverName").value = ""
                        }
                    }
                }
                
                //Check for Customer Name entry
                if(document.getElementById("txtDriverName"))
                {
                    if(document.getElementById("txtDriverName").value != "")
                    {
                        if(document.getElementById("txtDriverCode"))
                        {
                            document.getElementById("txtDriverCode").value = ""
                        }
                    }
                }
            }
            
            function SelectCustomer(objDriver)
            {
                var mQSParam = "<%=byteQSParam %>"
                alert("hi..")
                if(mQSParam == 13)
                {
                    window.opener.document.forms[0].txtDriverCode.value = objDriver.value
                }
                
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                var mSelectedControlName = objDriver.name;
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptDriver$ctl" + "0" + i + "$"
                    }
                    else
                    {
                        mDerivedControlName = "rptDriver$ctl" + i + "$"
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
                    <td align="left" style="height: 32px">
                        <label id="lblNoteBU" class="blackfnt">
                            <b>
                                <u>
                                    Note:         
                                </u>
                            </b>
                        </label>
                        <br />
                        <label id="lblNote" class="blackfnt">
                            - For All Driver list,keep blank both the input box.
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
                        <label id="lblDrvCode" class="blackfnt">
                            Driver Code
                        </label>
                    </td>
                    
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtDriverCode" runat="server" onblur= "ConvertToUpper(this)" class="inp"/>
                    </td>
                </tr>
                
                <tr>
                    <td align="left">
                        <label id="lblDrvName" class="blackfnt">
                            Driver Name
                        </label>
                    </td>
                    <td align="left">
                        &nbsp;
                        <input type="text" id="txtDriverName" runat="server" onblur= "ManageCustomerCodeName()" class="inp"/>
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
                            - Click on radio buton to select Driver.
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
                        &nbsp;
                        <label id="lblDrvCodeColHeader" class="blackfnt">
                            Driver Code
                        </label>
                    </td>
                    <td align="left">
                        &nbsp;
                        <label id="lblDrvNameColHeader" class="blackfnt">
                            Driver Name
                        </label>
                    </td>
                </tr>
                
                <asp:Repeater ID="rptDriver" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <input id="radSelBranch" type="radio" value='<%# DataBinder.Eval(Container.DataItem, "Driver_id")%>' onclick="SelectCustomer(this);" runat="server" />
                            </td>
                            <td style="width: 30%" align="left">
                                <label id="lblRptDrvCode1" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "Manual_Driver_Code")%>
                                </label>
                            </td>
                            
                            <td align="left">
                                <label id="lblRptDrvName1" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "Driver_Name")%>
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
