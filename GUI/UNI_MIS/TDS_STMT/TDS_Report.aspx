<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="TDS_Report.aspx.cs" Inherits="GUI_UNI_MIS_TDS_STMT_TDS_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


 


   <div align="left" style="width: 10in">
        <br />
        <table align="left" style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>TDS Regester Report</b></font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
    <table align="Left" border="0" cellpadding="5" cellspacing="1" class="boxbg" width="50%">
     <tr align="center" style="background-color: #ffffff">
            <td align="center"  class="dgHeaderStyle" colspan="2" style="height: 10px">
                <label>
                    You Selected</label></td>
           
        </tr>
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Party</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblCode" runat="server" CssClass="blackfnt"></asp:Label>
                :
                <asp:Label ID="lblName" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px; height: 15px">
                <label class="blackfnt">
                    Date Range</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px">
                <label class="blackfnt">
                    Branch Name</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblBranch" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
    </table>
    <br /> <br />
        <br />
        <br /> <br />
        <br />
        <br />       <br />
        <br />
        <br /> <br />
        <br />
        <br />
        
    <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="Left">
                <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
                    <ContentTemplate>
                        <center>
                            <asp:GridView ID="dgTDSRpt" runat="server" AllowPaging="True"  BorderWidth="0"
                                 CellPadding="5" CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..."
                                HeaderStyle-CssClass="dgHeaderStyle" OnPageIndexChanging="pgChange" PagerSettings-Mode="Numeric"
                                PagerStyle-HorizontalAlign="left" PageSize="25" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO." HeaderStyle-Font-Bold="true" >
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="Entry No" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="docno">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    
                                    <asp:BoundField HeaderText="Entry Date" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="dt"  >
                                        <ItemStyle HorizontalAlign="Left"   />
                                        <HeaderStyle HorizontalAlign="Left" Wrap="true"   />
                                    </asp:BoundField>
                                    
                                    
                                    <asp:BoundField HeaderText="Amount" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="billamt">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Account Head" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="oppaccdesc">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Party" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="pbov_Name">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="TDS Receivable " ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="tds">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Surcharge  " ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="svctax">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Education Cess " ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="cess">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Total Receivable  " ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="amtnew">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Mode of Payment" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Cheque No" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="chqno">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Cheque Date" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="chqdt">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Amount Paid" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="TDS Paid Bank Name" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="bankname">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Bank Branch" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="bankbrn">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="Payment Date" ItemStyle-BackColor="white" ItemStyle-CssClass="blackfnt" DataField="paydt">
                                        <ItemStyle HorizontalAlign="Left" />
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                </Columns>
                          <%--      <RowStyle BorderColor="Black" BorderStyle="None"  BorderWidth="1px" />--%>
                                <PagerStyle HorizontalAlign="Left" />
                                <HeaderStyle CssClass="dgHeaderStyle" />
                            </asp:GridView>
                        </center>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <br />
    <div style="width:10in" align="center" >
    <asp:Button ID="btn_csv" Text="Download XLS" runat="server"  Width="170" OnClick="btn_csv_Click" /></div>
    </div>
</asp:Content>
