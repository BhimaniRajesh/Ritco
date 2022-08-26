<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_OPN_LIFE_CYCLE_Result" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <script language="JavaScript" type="text/javascript">
function OpenPopupWindow(strDocketNo,strDcksf,strDckty)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            
            var strPopupURL = "PopUp_result.aspx?strDocketNo="+strDocketNo+"&strDckty="+strDckty+"&strDcksf="+strDcksf               
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        </script>
<table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Consignment Lifecycle Report</strong> </font>
            </td>
        </tr>
         <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1" /></td>
        </tr>
          <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
      
    <br />
    <tr>
            <td valign="top"><table border="0" id="TB_CRI" runat="server"  HorizontalAlign="left"  CellPadding="3" CellSpacing="1" style="width:5.5in;" Class="boxbg">
    <tr bgcolor="white" class="blackfnt"><td>Date</td><td><asp:Label  runat="server" ID="LBLDATE"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>RO</td><td><asp:Label  runat="server" ID="LBLRPT"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Branch</td><td><asp:Label  runat="server" ID="LBLBRANCH"></asp:Label></td></tr>
    </table>
    
     <br /></td>
        </tr>
       <tr>
            <td valign="top"><br />
                
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
        
      <tr>
            <td valign="top">
    <br />
   <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
         PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
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
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "docket")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColDockdt" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                 <asp:BoundField DataField="orgncd" HeaderText="Origin">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white"  Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="destcd" HeaderText="Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="from_loc" HeaderText="From">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="to_loc" HeaderText="To">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Curr_loc" HeaderText="Current Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="nextloc" HeaderText="Next Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:TemplateField HeaderText="LS" ItemStyle-BackColor="white">
                <ItemTemplate>
                  <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>','LS')" ><font class="blacknft"><u><%#DataBinder.Eval(Container.DataItem, "LS") %></u></font></a>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="MF" ItemStyle-BackColor="white">
                <ItemTemplate>
                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>','MF')" ><font class="blacknft"><u><%#DataBinder.Eval(Container.DataItem, "MF") %></u></font></a>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="THC" ItemStyle-BackColor="white">
                <ItemTemplate>
                <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>','THC')" ><font class="blacknft"><u><%#DataBinder.Eval(Container.DataItem, "THC") %></u></font></a>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="PRS" ItemStyle-BackColor="white">
                <ItemTemplate>
 <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>','PRS')" ><font class="blacknft"><u><%#DataBinder.Eval(Container.DataItem, "PDC") %></u></font></a>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="DRS" ItemStyle-BackColor="white">
                <ItemTemplate>
 <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "dockno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>','DRS')" ><font class="blacknft"><u><%#DataBinder.Eval(Container.DataItem, "DRS") %></u></font></a>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
                 <asp:BoundField DataField="Status" HeaderText="Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"    CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
            </Columns>
             <RowStyle />
        <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings Position=TopAndBottom FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
            </asp:GridView>
    <br />
    </td>
 </tr>
 <tr>
            <td valign="top"><br />
                
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>



</table>
</asp:Content>
