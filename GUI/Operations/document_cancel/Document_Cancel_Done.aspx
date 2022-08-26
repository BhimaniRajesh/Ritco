<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Document_Cancel_Done.aspx.cs" Inherits="GUI_Operations_document_cancel_Document_Cancel_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<div align="center">
<br />
<asp:Panel ID="p2" runat="server">
     
     <p align="center"><font class="bluefnt"><b><%=doctype%> : has been successfully Cancelled.</b></font>
					     <br /><br /><a href="./document_cancel.aspx"><font class="blackfnt"><b><u>Click here to Cancel More Document(s)</u></b></font></a>
					     <p>
     
     </asp:Panel>
</div>
</asp:Content>
