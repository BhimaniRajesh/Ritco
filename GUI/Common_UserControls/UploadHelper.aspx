<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadHelper.aspx.cs" Theme="Blue" Inherits="GUI_Common_UserControls_UploadHelper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function closeWindow(data) {
            window.opener.popupCallback(data);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table class="boxbg">
            <tr class="nrow">
                <td>Document Declaration : </td>
                <td>
                    <asp:FileUpload runat="server" ID="fileDeclaration" />
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="2">
                    <asp:Button ID="fileSave" runat="server" OnClick="fileSave_Click" Text="Upload Document" />
                </td>
            </tr>
            <tr class="nrow">
                <td colspan="2">
                    <asp:Label ID="lblInfo" ForeColor="Red" runat="server" Text="" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>