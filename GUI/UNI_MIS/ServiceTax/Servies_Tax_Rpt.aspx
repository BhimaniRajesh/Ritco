<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Servies_Tax_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_ServiceTax_Servies_Tax_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
        function OpenPopup(MR_Number) 
        { 
            window.open("MR_Summ_Popup.aspx?MR_Number=" + MR_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
</script>

    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Service Tax"></asp:Label><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    MR Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    MR Party</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblParty" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    MR Type</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                MR RO</td>
            <td style="width: 343px">
                <asp:Label ID="lblRO" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                MR Branch</td>
            <td style="width: 343px">
                <asp:Label ID="lblBranch" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Amount Greater Than</td>
            <td style="width: 343px">
                <asp:Label ID="lblAmount" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
       
    <br />
    <br/>
       <table border="0" style="width: 98%; background-color: #808080" align="center" cellspacing="1" cellpadding="2" class="boxbg">
       
        <tr class="bgbluegrey"><td style="width: 5%;" rowspan="2"><label class="blackfnt">Sr. No</label></td>
       
        <td align="center" rowspan="2"><label class="blackfnt">MR Number</label></td>
       
        <td align="center" rowspan="2"><label class="blackfnt">Docket No</label></td>
       
        <td align="center" rowspan="2"><label class="blackfnt">MR Type</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">MR Date</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">MR Party</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">MR Branch</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">MR Amount</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">Service Tax Rate</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">Cess Rate</label></td>
        
        <td align="center" colspan="3"><label class="blackfnt">Docket</label></td>
        
        <td align="center" colspan="3"><label class="blackfnt">Other Deduction&nbsp;</label></td>
        
        <td align="center" colspan="3"><label class="blackfnt">Other Charges</label></td>
        
        <td align="center" colspan="3"><label class="blackfnt">Received</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">TDS Deduction</label></td>
        
        <td align="center" rowspan="2"><label class="blackfnt">Net Amount</label></td>
                                                                        
        </tr>
        <tr class="bgbluegrey">
               <td align="center" class="blackfnt">
                   Freight</td>
               <td align="center" class="blackfnt">
                   Service Tax</td>
               <td align="center" class="blackfnt">
                   Cess</td>
               <td align="center" class="blackfnt">
                   Freight</td>
               <td align="center" class="blackfnt">
                   Service Tax</td>
               <td align="center" class="blackfnt">
                   Cess</td>
               <td align="center" class="blackfnt">
                   Freight</td>
               <td align="center" class="blackfnt">
                   Service Tax</td>
               <td align="center" class="blackfnt">
                   Cess</td>
               <td align="center" class="blackfnt">
                   Freight</td>
               <td align="center" class="blackfnt">
                   Service Tax</td>
               <td align="center" class="blackfnt">
                   Cess</td>
           </tr>
        <asp:Repeater ID="rptBillDetails" runat="server">
        
        <ItemTemplate>
        
                <tr style="background-color: White">
                    <td style="width: 198px"><center>
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                        </label></center>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                        <asp:HyperLink Runat="server"  Font-Underline="True"  ForeColor="#000099" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "NavURL")%>' Text='<%#DataBinder.Eval(Container.DataItem, "MR_Number")%>' ID="Hyperlink1">
                                </asp:HyperLink>                        
                        </label>
                    </td>                    
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "DocNo")%>                    
                         </label>
                    </td>
                           
                           <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "MR_Type")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "MR_Date")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "MR_Party")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "MR_Branch")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "MR_Amt")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Svc_Tax")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Cess_Rate")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Doc_Fre")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Doc_Svc")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Doc_Cess")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Dedu_Fre")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Dedu_Svc")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Dedu_Cess")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Chrg_Fre")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Chrg_Svc")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Chrg_Cess")%>                    
                         </label>
                         </td>
                    
                         <td>
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Rec_Fre")%>                    
                         </label></td>
                     
                         <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Rec_Svc")%>                    
                         </label></td>  
                         <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Rec_Cess")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "TDS")%>                    
                         </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt"> 
                        <%#DataBinder.Eval(Container.DataItem, "Net_Amt")%>                    
                         </label>
                    </td>                         
                </tr>
            </ItemTemplate>
        </asp:Repeater>
           
        <tr style="background-color: #FFFFFF" runat="server" id="trForTotalValues"> 
                                                                        <td colspan="7" align="right">
                                                                            <label class="blackfnt">
                                                                                <b>
                                                                                    Total :
                                                                                </b>
                                                                            </label>
                                                                        </td>
                                                                                                                                                   
                                                                           <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblMRAmt" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td>
                                                                        <td align="center"></td>
                                                                        <td align="center"></td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblDocFre" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td>
                                                                        
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblDocSer" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td>
                                                                        
                                                                        <td align="center" ><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblDocCess" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td>
                                                                        
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblDeduFre" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td>
                                                                        
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblDeduSer" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                               <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblDeduCess" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td>                                                              
                                                                    <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblChrgFre" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblChrgSer" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblChrgCess" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblRecFre" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblRecSer" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblRecCess" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblTDS" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                        <td align="center"><center>
                                                                            <asp:Label cssclass="blackfnt" ID="lblNetAmt" runat="server" Font-Bold="true">
                                                                            </asp:Label></center>
                                                                        </td> 
                                                                    </tr>        
    </table>
    
    <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080" 
                                                                    align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
                                                                    <tr style="background-color: #ffffff">
                                                                        <td colspan="22" align="right" style="width: 892px; height: 23px;">
                                                                            <div align="center">
                                                                                <label style="color: #FF0000;" class="blackfnt">
                                                                                    No Record Found
                                                                                </label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    </table>
    <br />
                                                                    <table border="0" align="center" cellpadding="0" cellspacing="4" 
                                                    id="tblPageNavigation" runat="server">
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                Page&nbsp;
                                                                <asp:Label id="CurrentPage" CssClass="blackfnt" runat="server" />
                                                                &nbsp;of&nbsp;
                                                                <asp:Label id="TotalPages" CssClass="blackfnt" runat="server" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    
                                                  <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" id="FirstPage" Text="[First Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="First" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="PreviousPage" Text="[Previous Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Prev" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="NextPage" Text="[Next Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Next" />    
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="LastPage" Text="[Last Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Last" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                            </label>
                                                            <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)" visible="false">
                                                            </select>
                                                            <input type="hidden" id="HIDCurrentPageNo" runat="server"/>
                                                        </td>
                                                    </tr>
                                                    </table>
                                                    <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                   			                                            
			                                                <td align="center">
                                                                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>   			                                            
			                                                
			                                            </tr>
		                                            </table> 
</asp:Content>
