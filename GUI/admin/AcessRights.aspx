<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AcessRights.aspx.cs" Inherits="GUI_admin_AcessRights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Access Rights" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
<div align="center">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
            <table align="center">
  <tr>
    <td style="width: 170px"><font class="bluefnt"><strong>Enter Location Code</strong></font></td>
	<td><asp:TextBox ID="txtLocCode" runat="server" MaxLength="6" width="40px"></asp:TextBox></td>
	<td><asp:Button ID="btnLocCode" runat="server" Text="GO" OnClick="btnLocCode_Click" /></td>
  </tr>
   <tr>
    <td colspan="2" align="center" style="height: 18px"><font class="blackfnt"><strong>OR</strong></font></td>
  </tr>
  <tr>
    <td style="width: 170px"><font class="bluefnt"><strong>Enter Employee Code</strong></font></td>
	<td><asp:TextBox ID="txtEmpCode" runat="server" MaxLength="6" width="40px"></asp:TextBox></td>
	<td><asp:Button ID="btnEMpCode" runat="server" Text="GO" OnClick="btnEMpCode_Click" /></td>
  </tr>
</table>
      <br />
      
      <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 100%; background-color: #808080">
      
      <tr class="bgbluegrey" >
	   <td align="center" rowspan="3"><font class="bluefnt"><strong>Emp ID</strong></font></td>
	   <td align="center" rowspan="3"><font class="bluefnt"><strong>Employee Name</strong></font></td>
	  <td align="center" colspan="20"><font class="bluefnt"><strong>Module Access Area</strong></font></td>
	</tr>
	<tr class="bgbluegrey">
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Operation</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Finance</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Marketing</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Admin</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Reports</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Tracking</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Octroi</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>CRM</strong></font></td>
	  <td align="center" colspan="2"><font class="blackfnt"><strong>Exception</strong></font></td>
	  
	  
	</tr>
   <tr class="bgbluegrey">
	  
	  <td align="center" style="width: 49px"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	  <td align="center"><font class="blackfnt">Access</font></td>
	  <td align="center"><font class="blackfnt">Privilege</font></td>
	 
	  
	  
	</tr>
	
	<asp:Repeater ID="rptAccess" runat="server" Visible="false">
            <ItemTemplate>
                <tr style="background-color: White">
                    <td style="width: 198px">
                        
                        <asp:Label ID="lblempcode" CssClass="blackfnt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EMPCD")%>'></asp:Label>
                           <%-- <label id="empcode" class="blackfnt" >
                                <%#DataBinder.Eval(Container.DataItem, "EMPCD")%>
                            </label>--%>
                        
                    </td>
                    <td>
                    
                        <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "EMPNM")%>
                        </label>
                        
                    </td>
                    
                    <td><%--<input type="checkbox" >--%>
                     <asp:CheckBox ID="CheckBox1" runat="server" /><asp:Label ID="chkdisp" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OPN")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox2" runat="server" /><asp:Label ID="chkdisp2" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OPN_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox3" runat="server" /><asp:Label ID="chkdisp3" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FIN")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox4" runat="server" /><asp:Label ID="chkdisp4" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FIN_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    <td>
                    <asp:CheckBox ID="CheckBox5" runat="server" /><asp:Label ID="chkdisp5" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "MKT")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox6" runat="server" /><asp:Label ID="chkdisp6" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "MKT_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    <asp:CheckBox ID="CheckBox7" runat="server" /><asp:Label ID="chkdisp7" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ADM")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox8" runat="server" /><asp:Label ID="chkdisp8" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox9" runat="server" /><asp:Label ID="chkdisp9" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "REP")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox10" runat="server" /><asp:Label ID="chkdisp10" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                    
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox11" runat="server" /><asp:Label ID="chkdisp11" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "TRK")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox12" runat="server" /><asp:Label ID="chkdisp12" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "TRK_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    <td>
                    <asp:CheckBox ID="CheckBox13" runat="server" /><asp:Label ID="chkdisp13" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCTROI")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox14" runat="server" /><asp:Label ID="chkdisp14" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCT_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox15" runat="server" /><asp:Label ID="chkdisp15" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CRM")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox16" runat="server" /><asp:Label ID="chkdisp16" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CRM_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox17" runat="server" /><asp:Label ID="chkdisp17" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EXC")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox18" runat="server" /><asp:Label ID="chkdisp18" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EXC_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                    </tr>
                    
                    </ItemTemplate>
                    </asp:Repeater>
                    
                    
                    
                    <asp:Repeater ID="rptEmp" runat="server" Visible="false">
            <ItemTemplate>
                <tr style="background-color: White">
                    <td style="width: 198px">
                        
                         <asp:Label ID="lblempcode1" CssClass="blackfnt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EMPCD")%>'></asp:Label>
                        
                            <%--<label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "EMPCD")%>
                            </label>--%>
                        
                    </td>
                    <td>
                    
                        <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "EMPNM")%>
                        </label>
                        
                    </td>
                    
                    <td><%--<input type="checkbox" >--%>
                     <asp:CheckBox ID="CheckBox19" runat="server" /><asp:Label ID="chkdisp19" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OPN")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox20" runat="server" /><asp:Label ID="chkdisp20" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OPN_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox21" runat="server" /><asp:Label ID="chkdisp21" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FIN")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox22" runat="server" /><asp:Label ID="chkdisp22" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "FIN_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                     <td><%--<input type="checkbox" >--%>
                     <asp:CheckBox ID="CheckBox23" runat="server" /><asp:Label ID="chkdisp23" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "MKT")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox24" runat="server" /><asp:Label ID="chkdisp24" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "MKT_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox25" runat="server" /><asp:Label ID="chkdisp25" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ADM")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox26" runat="server" /><asp:Label ID="chkdisp26" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                     <td><%--<input type="checkbox" >--%>
                     <asp:CheckBox ID="CheckBox27" runat="server" /><asp:Label ID="chkdisp27" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "REP")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox28" runat="server" /><asp:Label ID="chkdisp28" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox29" runat="server" /><asp:Label ID="chkdisp29" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "TRK")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox30" runat="server" /><asp:Label ID="chkdisp30" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "TRK_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                     <td><%--<input type="checkbox" >--%>
                     <asp:CheckBox ID="CheckBox31" runat="server" /><asp:Label ID="chkdisp31" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCTROI")%>'></asp:Label>
                     <%--<%#DataBinder.Eval(Container.DataItem, "ADM")%>--%>
                     
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox32" runat="server" /><asp:Label ID="chkdisp32" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCT_Plevel")%>'></asp:Label>
                                <%--<%#DataBinder.Eval(Container.DataItem, "ADM_Plevel")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox33" runat="server" /><asp:Label ID="chkdisp33" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CRM")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox34" runat="server" /><asp:Label ID="chkdisp34" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CRM_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                   
                   <td>
                    
                        <asp:CheckBox ID="CheckBox35" runat="server" /><asp:Label ID="chkdisp35" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EXC")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP")%>--%>
                        
                    </td>
                    
                    <td>
                    
                        <asp:CheckBox ID="CheckBox36" runat="server" /><asp:Label ID="chkdisp36" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EXC_Plevel")%>'></asp:Label>
                               <%-- <%#DataBinder.Eval(Container.DataItem, "REP_Plevel")%>--%>
                        
                    </td>
                    
                    </tr>
                    
                    </ItemTemplate>
                    </asp:Repeater>
                    
      </table> 
      
      <br />
      <div align="center"><asp:Button ID="btnSubmitLoc" runat="server"  Text="Submit" Width="70px" Visible="false" OnClick="btnSubmitLoc_Click" /></div>
      <div align="center"><asp:Button ID="btnSubmitEmp" runat="server" Text="Submit" Width="70px" Visible="false" OnClick="btnSubmitEmp_Click"/></div>
      
      
           
            </div>
            </asp:Content>
