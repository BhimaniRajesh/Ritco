<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ContractScanCopyUpload.aspx.cs" Inherits="GUI_admin_ContractScanCopyUpload"
    Title="Untitled Page" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">      
/*************************************************************************************************************
*   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
/*************************************************************************************************************/             
function btnSubmitCheck()
{       
        var uplTheFile = document.getElementById("uplTheFile");   
        if(uplTheFile.value == "")
        {
                alert("Please browse file to upload.");
                uplTheFile.focus();
                return false;
        }
        return true;         
}
    </script>
</head> 
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="Panel1" runat="server" Width="10in">     
        <asp:Table runat="server" CssClass="boxbg" HorizontalAlign="left" CellSpacing="1"
            Width="100%" ID="tblMain">
             <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
                        Scanned Contract Copy Upload 
                </asp:TableCell>
            </asp:TableRow>  
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2">
                        <cust:CustInfo runat="server" ID="cstheader" /> 
                </asp:TableCell>
            </asp:TableRow>         
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
                            Select file 
                </asp:TableCell>
                <asp:TableCell>
                    <asp:FileUpload ID="uplTheFile" runat="server" BorderStyle="Groove" CssClass="blackfnt" tabindex="3" style="width: 350px" />                    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2">
                    <asp:Button ID="btnUploadFile" runat="server" Text="Upload File" Width="100px" CssClass="blackfnt"
                       OnClientClick="javascript:return btnSubmitCheck()" TabIndex="4" OnClick="btnUploadFile_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdnContractID" runat="server" />  
    </asp:Panel>    
    </form>
</body>
</html>

