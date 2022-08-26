<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="LSList_For_Update.aspx.cs" Inherits="GUI_Operations_LS_ver2_LSList_For_Update" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">

function OpenPopupWindow(strDocketNo,NextLOC)
        {         
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=50"
             var strPopupURL = "./MFCreateMain_FromLS.aspx?strDckNo="+strDocketNo+"&NextLOC="+ NextLOC 
             winNew = window.open(strPopupURL, "_self", strWinFeature)
        }
        </script>
 <table cellspacing="1" style="width: 700px">
        <tr style="background-color: white">
            <td align="left" width="75%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update <%=strDocumentLS%>  & Prepare Manifest  </asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
            <td align="left">
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <table border="0" cellspacing="1" cellpadding="3" width="900px"  id="Table1"
                runat="server" visible="true">
                <tr >
                    <td  align="left">
                     <asp:GridView Visible="false" align="left" ID="dgLS" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" CssClass="boxbg"
                    AllowPaging="false" AutoGenerateColumns="false"   EmptyDataText="No Records Found..." >
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <HeaderTemplate>
                                <asp:Label CssClass="blackfnt" Text="LS No."  ID="lblColname" runat="server"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                            <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "tcno") %>','<%#DataBinder.Eval(Container.DataItem, "tobh_code") %>')"><asp:Label Font-Underline="true" CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "tcno")%>'
                                    runat="server">
                                </asp:Label></a>
                                
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center"  />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ManualLSno" HeaderText=" Manual LS No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcdt" HeaderText="LS Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="LOC" HeaderText="Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dockets">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tot_pkgs" HeaderText="Total Packages">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tot_actuwt" HeaderText="Total Weight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Print_v" HeaderText="Print">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        </Columns>
                    <RowStyle />
                  
                    <HeaderStyle CssClass="bgbluegrey" />
                    
                </asp:GridView>
                        </td>
                </tr>
                </table>
</asp:Content>
