<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Advance_Payment.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_GRN_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1) {
            window.open("DDMRProcess_View.aspx?DDMRNo=" + arg1 , "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=700,height=500,status=no,left=60,top=125");
        }
    
    </script>

    
</asp:Content>
