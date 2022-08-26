<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Cumulative_ Result_CBS.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance12" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 
   <table id="Table3"  runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" >
      <tr><td></td></tr>
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 12px"><font class="blackboldfnt">Reports</font> > <a href="../../rpt_finance.aspx"><font class="blklnkund">Finace & Accounts </font></a>></font><font class="bluefnt"> Cash & Bank Statement  </font></td></tr>  
       <tr> 
          
        </tr>
        </table>
        <br /> <br />       
       <%--<table border="0" style="width: 98%; background-color: #808080" align="center" cellspacing="1" cellpadding="2" class="boxbg">
       
        <tr class="bgbluegrey"><td style="width: 5%; height: 25px;"><label class="blackfnt">Sr. No</label></td>
     
        
        <td><label class="blackfnt">Particulars </label></td>
       
         <asp:Repeater ID="Repeater_BankName" runat="server">  
        <ItemTemplate>
    <td style="width: 198px"><center>
                        <label  class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "accdesc")%>
                        </label></center>
                    </td>
             </ItemTemplate></asp:Repeater>                                              
        </tr>
        
        
       
        
        <asp:Repeater ID="rptBillDetails" OnItemDataBound="abcd" runat="server">        
        <ItemTemplate>
        
                <tr style="background-color: White">
                    <td style="width: 198px"><center>
                        <label class="blackfnt" >
                            <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                        </label></center>
                    </td>
                    <td colspan="<%#DataBinder.Eval(Container.DataItem, "clospn")%>" > <center>              
                        <label   class="blackfnt" id="Label13" runat="server" >
                           <b>  <%#DataBinder.Eval(Container.DataItem, "locname")%></b>
                        </label> 
                        <asp:Label cssclass="blackfnt" id="Label1" runat="server"><%#DataBinder.Eval(Container.DataItem, "locname")%></asp:Label> </center>
                    </td>
                    
                   
                                                      
                </tr>
                <tr bgcolor="#FFFFFF"> 
    <td height="24" width="22">&nbsp;</td>
    <td height="24" width="129" ><font class="blackfnt">Opening Balance </font></td>
   <%--<asp:Repeater ID="rptOPNBAL" runat="server">    
       
        <ItemTemplate>
        
        
       
     <td style="width: 198px"><center>
                        <asp:Label cssclass="blackfnt" id="lblOPNbal" Text='<%#DataBinder.Eval(Container.DataItem, "OPNBalnce")%>'  runat="server">
                                                                            </asp:Label></center>
                    </td>
    <%--</ItemTemplate></asp:Repeater>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td height="24" width="22">&nbsp;</td>
    <td height="24" width="129" ><font class="blackfnt">Closing  Balance </font></td>
   <td height="24" width="70" align="right"><font class="blackfnt"></font></td>
   
  </tr>
            </ItemTemplate>
        </asp:Repeater>
         
        
       
    </table>--%>
    
       <asp:Table id="tblheadache" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
    
    <br />
    <br/>
       <%--<table border="0" style="width: 98%; background-color: #808080" align="center" cellspacing="1" cellpadding="2" class="boxbg">
       
        <tr bgcolor="#FFFFFF">
       
        <td><label class="blackfnt">Prepare By</label></td>
       
        <td height="24"  align="right"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblPrepareBy" runat="server" Font-Bold="true">
                                                                            </asp:Label></font></td>
        <td><label class="blackfnt">At </label></td>
       
      <td height="24"  align="right"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblAt" runat="server" Font-Bold="true">
                                                                            </asp:Label></font></td>
        <td><label class="blackfnt">Date & Time </label></td>
        <td height="24"  align="right"><font class="blackfnt"><asp:Label cssclass="blackfnt" ID="lblDateTime" runat="server" Font-Bold="true">
                                                                            </asp:Label></font></td>
       
       
                                               
        </tr>
        
        <tr bgcolor="#FFFFFF">
       
        <td><label class="blackfnt">Certified & Approved By</label></td>
       
        <td><label class="blackfnt"></label></td>
        <td><label class="blackfnt"> </label></td>
       
        <td><label class="blackfnt"></label></td>
        <td><label class="blackfnt"></label></td>
       
       <td height="28"  > 
      <center>
        <font class="blackfnt"></font> 
      </center>
    </td>
                                               
        </tr>
        </table>--%>
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
                                                                   
                                                    
                                                    
                                                   <table id="Table2"   runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td><asp:Button ID="btnShow" runat="server" Text="XLS Download"  OnClick="btnShow_Click" Width="75px"  /></td></tr>  
 
        </table>
                                                   
                                                  
                                                   <%-- <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                   			                                            
			                                                <td align="center">
                                                                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>   			                                            
			                                                
			                                            </tr>
		                                            </table> --%>
</asp:Content>

