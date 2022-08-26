<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Back_Date_Control.aspx.cs" Inherits="GUI_Fleet_TripRuleMaster_BackDateControl_Back_Date_Control" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
     <script type="text/javascript" language="JavaScript" src="../../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        function openEmployee(id)
        {  
            window.open("frmEmployee.aspx?id=" + id + "" ,'myWindow','height=440,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
         <asp:Panel ID="Panel1" Width="10in" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  RenderMode="Inline" runat="server">
            <ContentTemplate>
                <table width="7in">
                    <tr>
                        <td>
                            <asp:GridView align="center" ID="grvDateRule" runat="server" BorderWidth="1" AutoGenerateColumns="false"
                                CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="hrow" AllowSorting="true"
                                ShowFooter="false" AllowPaging="false" HeaderStyle-Wrap="true" RowStyle-CssClass="nrow"
                                Width="7in" CssClass="stbl" FooterStyle-CssClass="frow" RowStyle-Wrap="false"
                                EmptyDataText="No Records Found..." OnRowDataBound="grvDateRule_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Srno">
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblSrno" Text='<%# Container.DataItemIndex + 1 %>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Module Name" ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lbl_ModuleName" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Module_name") %>'></asp:Label>
                                            <asp:HiddenField ID="Hnd_Srno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Srno") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Allow BackDate Y/N">
                                        <ItemStyle HorizontalAlign="Center" /> 
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkAllowBackDate" runat="server" />
                                            <%--<asp:HiddenField runat="server" ID="hdnAllowBackDate" Value="'<%# DataBinder.Eval(Container.DataItem,"Rule_Y_N") %>'" />--%>
                                            <asp:HiddenField ID="hdnAllowBackDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Rule_Y_N") %>' />
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="BackDate Days">
                                        <ItemTemplate>
                                            <asp:TextBox BorderStyle="Groove" CssClass="rtxt" ID="txtBackDate" onkeypress="javascript:return validInt(event)"
                                                runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BackDate_Days") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Min Date" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:TextBox BorderStyle="Groove" CssClass="rtxt" ID="txtMinDate" runat="server"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"Min_Date") %>'></asp:TextBox>
                                            <asp:HyperLink ID="hypCAL" runat="server" NavigateUrl="#">
                                                <img src="../../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                            </asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="BackDate Allow -Empcd" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:TextBox BorderStyle="Groove" ID="txtEmpcd" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Empcd") %>'
                                                TextMode="MultiLine" MaxLength="500"></asp:TextBox>
                                            <asp:Button ID="btnEmpCode" UseSubmitBehavior="false" runat="server" Text="..." />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="frow">
                        <td align="center">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="fbtn" Text="Submit" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
                <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                    z-index: 99;">
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    </div>
    </form>
</body>
</html>
