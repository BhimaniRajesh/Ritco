
<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="genbillsdone_1.aspx.cs" Inherits="Finance_Billing_Billgeneration_genbillsdone"   %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />--%>
     <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
      <script language="javascript" type="text/javascript" src="../Billing.js"></script>
       
    <script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
    </script>
    
    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
	 
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
    </script>
        
<%--</head>

<body>
    <form id="form1" method="post"  runat="server">--%>
    <div>
 
    <table style="width:10in"border="0" cellpadding="0" cellspacing="0">
    <asp:HiddenField ID="click_count" runat="server" Value="0"  />
  <tr> 
    <td>&nbsp;</td>
  </tr>
   
   <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    <tr>
    <td>
     <table   border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width:80%"  align="Left">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center" style="height: 25px"><font class="blackfnt"><b> Bill Generation</b></font></td>
            
       </tr>
       <tr bgcolor="white" >
            <td align="Left"><font class="blackfnt">Customer Code and Name</font></td>
            <td>
                <asp:Label ID="lblparty" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        <tr bgcolor="white"  >
         <td   align="Left"><font class="blackfnt">Docket 
        Booking Date Range </font></td>
            <td style="width: 339px; height: 25px;">
                <asp:Label ID="lbldaterange" runat="server" Text="Label" Width="313px" CssClass="blackfnt"></asp:Label></td>
           
       </tr>
        <tr bgcolor="white" >
        <td    align="Left"><font class="blackfnt">Pay Basis</font>
            </td>
            <td>
                <asp:Label ID="lblpaybas" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        <tr bgcolor="white"  >
            <td style="width: 282px"  align="Left"><font class="blackfnt">Mode Of Transport</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblmod" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
       </tr>
        <tr bgcolor="white"   runat="server" id="Tr_but"  visible="false">
            <td align="Left"><font class="blackfnt">Business Type</font></td>
            <td >
                <asp:Label ID="Lblbut" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
       </tr>
       </table>
       </td></tr>
       <tr><td>
        <br />
        <table align="left" border="0" cellpadding="2" cellspacing="1" class="boxbg"  >
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 148px">
                    <font class="blackfnt">Bill Number</font>
                </td>
                <td  >
                    <font class="blackfnt" color="red"> <b>System Generated...</b></font></td>
                <td  >
                    <font class="blackfnt"> Bill Branch </font></td>
                <td  colspan="2"> <font class="blackfnt">  <%=Session["brcd"].ToString() %></font>
                </td>
            </tr>
            <tr bgcolor="white">
                <td  >
                    <font class="blackfnt"> Bill Date </font>
                    
                    </td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtbgndt"   runat="server"   MaxLength="10"  onblur="javascript:return ValidateDate(this);"   Width="65" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                   <a HREF="#"  onClick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtbgndt,'anchor112','dd/MM/yyyy'); return false;"  NAME="anchor112" ID="anchor112" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                   </td>
                <td  >
                 <font class="blackfnt">  Due Date </font></td>
                <td    colspan="2">
                    <asp:TextBox ID="txtduedate" runat="server"      MaxLength="10"   Width="65" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                     <a HREF="#"  onClick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtduedate,'anchor1','dd/MM/yyyy'); return false;"  NAME="anchor1" ID="anchor1" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                                                    </td>
            </tr>
            <tr bgcolor="white" >
                <td style="width: 148px">
                   <font class="blackfnt">  Bill Type </font></td>
                <td>
                    <font class="blackfnt"> Freight Bill</font> </td>
                <td  >
                   <font class="blackfnt"> Party name </font></td>
                <td   colspan="2" nowrap>
                    <asp:Label ID="LblPTMSCD"  Font-Bold="true" runat="server" Text="Label" Width="257px"   CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr bgcolor="white" >
                <td  >
                   <font class="blackfnt"> Bill Submission at </font></td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtbillsubloc" runat="server" Width="200"  BorderStyle="Groove" CssClass="blackfnt" onblur="javascript:Customer_Location_Blur(this,'Location','N')"  ></asp:TextBox> <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                            <div id="Div1" runat="server" class="boxbg" />
                            <%--<atlas:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"  DropDownPanelID="Abc" >
                              <atlas:AutoCompleteProperties TargetControlID="txtbillsubloc" ServicePath="../AtlasAutoComplete.asmx" 
                                        ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                              </atlas:AutoCompleteExtender>--%>
                              <ajaxtoolkit:autocompleteextender id="AutoCompleteExtender1" runat="server" enabled="True"
                                    completionlistitemcssclass="autocomplete_listItem" completionlisthighlighteditemcssclass="autocomplete_highlightedListItem"
                                    minimumprefixlength="1" servicemethod="GetLocation" servicepath="../AtlasAutoComplete.asmx"
                                    targetcontrolid="txtbillsubloc">
                                </ajaxtoolkit:autocompleteextender>
                              
                              </td>
                <td >
                    <font class="blackfnt">Billing Party Address</font></td>
                <td   colspan="2">
                 <asp:Label ID="Lbl_Party_address" runat="server" Text=""   CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white" >
                <td  >
                  <font class="blackfnt">  Bill Collection at </font></td>
                <td>
                    <font class="blackfnt">
                        <asp:TextBox ID="txtbillcolloc" runat="server" Width="200"  BorderStyle="Groove" CssClass="blackfnt" onblur="javascript:Customer_Location_Blur(this,'Location','N')"  ></asp:TextBox> <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                            <div id="Abc" runat="server" class="boxbg" />
                            <%--<atlas:AutoCompleteExtender ID="Ext1" runat="server"  DropDownPanelID="Abc" >
                              <atlas:AutoCompleteProperties TargetControlID="txtbillcolloc" ServicePath="AtlasAutoComplete.asmx" 
                                        ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                              </atlas:AutoCompleteExtender>--%>
                              
                              
                              <ajaxtoolkit:autocompleteextender id="Ext1" runat="server" enabled="True"
                                    completionlistitemcssclass="autocomplete_listItem" completionlisthighlighteditemcssclass="autocomplete_highlightedListItem"
                                    minimumprefixlength="1" servicemethod="GetLocation" servicepath="../AtlasAutoComplete.asmx"
                                    targetcontrolid="txtbillcolloc">
                                </ajaxtoolkit:autocompleteextender>
                              
                              </td>
                <td style="width: 203px">
                   <font class="blackfnt"> Party Phone Number</font></td>
                <td   colspan="2">
                 <asp:Label ID="Lbl_Party_tellno" runat="server" Text=""   CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white" >
                <td ><font class="blackfnt">Manual Billno.</font>
                
                </td>
                <td  >
                    <asp:TextBox ID="txtManualbillno" runat="server" MaxLength="50"    onchange="javascript:this.value=this.value.toUpperCase()" Width="200"  BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                </td>
                <td >
                   <font class="blackfnt"> Party E-mail</font></td>
                <td   colspan="2">
                <asp:Label ID="Lbl_Party_Email" runat="server" Text=""   CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white" >
                <td >
                    <font class="blackfnt">Remark</font></td>
                <td colspan="2"  >
                    <asp:TextBox ID="txtremars" runat="server"  Width ="300" Rows="2" TextMode="MultiLine" onchange="javascript:this.value=this.value.toUpperCase()" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox></td>
                    <td><font class="blackfnt">Total Bill Amount</font></td>
                    <td><asp:TextBox ID="Txt_BillAmt" runat="server" Text="0.00"  Enabled="false" Width="60"  style="text-align:right" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox> </td>
            </tr>
            <tr bgcolor="white" >
                <td  >
                   <font class="blackfnt"> Special Instruction</font></td>
                <td colspan="2" >
                    <asp:TextBox ID="txtspl_ins" runat="server" Width ="300" Rows="2" TextMode="MultiLine"  onchange="javascript:this.value=this.value.toUpperCase()" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox></td>
                    <td><font class="redfnt"><b>Credit Days</b></font></td>
                    <td><font class="redfnt"> <asp:Label ID="Lbl_Credit_days" runat="server" Text="0.00"  Font-Bold="true"  CssClass="blackfnt"></asp:Label> </td>
            </tr>
            <tr bgcolor="white" >
                <td  ><font class="redfnt"><b>Credit Limit</b></font></td>
                <td  ><font class="redfnt"> <asp:Label ID="Lbl_Credit_Limit" runat="server" Text=""  Font-Bold="true"  CssClass="blackfnt"></asp:Label> </font></td>
                <td  ><font class="redfnt"><b>OutStanding Amount(As On Date)</b></font></td>
                <td   align="right" ><font class="redfnt"><asp:Label ID="Lbl_Outstanding_amt" runat="server" Text=""  Font-Bold="true"  CssClass="blackfnt"></asp:Label> </font></td>
                <td></td>
            </tr>
        </table>
       <br />
       </td></tr>
       <tr><td>
       <br />
       <table   border="0" cellpadding="1" cellspacing="1"   style="width:80%"  align="Left">
       <tr   style="height:25px">
            <td colspan="2" align="center" style="height: 25px">
       <div id="object"    class="message" style="display:none;width:100%" runat="server"> Bill Amount is Greater then Credit Limit For The Same Customer.</div>
       
   <asp:DataGrid ID="dockdata"  align="center" runat="server" AutoGenerateColumns="False" Width="776px" 
                         BorderWidth="0"    CellSpacing="1" CellPadding="2"  BorderStyle="None"    CssClass="boxbg"      Style="text-align: left"   FooterStyle-BackColor="white"   Visible="true" DataKeyField="dockno" ShowFooter="true" >
                                    
                                 
                                    <HeaderStyle CssClass="bgbluegrey"  />
    <Columns>
    
    <asp:TemplateColumn  ItemStyle-BackColor="white"  ItemStyle-Wrap="false">
	<headertemplate>
	<asp:CheckBox ID="ChkAll" runat="server"  onclick="javascript:Check_All('dockdata','ChkAll','chkOrderNo','Y')"/>
	</headertemplate>
                                        <ItemTemplate >
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.ItemIndex+1 %>" runat="server"> </asp:Label>
                                         <asp:CheckBox ID="chkOrderNo" runat="server"  onclick="javascript:Check_Calc_IND('dockdata','ChkAll',this)"/>
                                        </ItemTemplate>
                                       </asp:TemplateColumn>
     <asp:TemplateColumn    ItemStyle-BackColor="white" HeaderText="Docket NO." HeaderStyle-Wrap="false" HeaderStyle-CssClass="">
	 
                <ItemTemplate>
                    <center>
                
                    <asp:Label CssClass="blackfnt" ID="docketno"   text ='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'   runat="server" >
                    </asp:Label>
                    </center>
                </ItemTemplate>
              
     </asp:TemplateColumn>

       
 <%--<asp:BoundColumn HeaderText="Docket NO." ReadOnly="True" DataField="docknosf"/>

    <asp:BoundColumn HeaderText="Paybas" ReadOnly="True" ItemStyle-Wrap="false"  DataField="paybasdesc"/>--%>

<asp:BoundColumn  ItemStyle-BackColor="white" HeaderText="Mode" ReadOnly="True" ItemStyle-Wrap="false"  DataField="modedesc"/>

<asp:BoundColumn ItemStyle-BackColor="white" HeaderText="Bkg Date : Comm Dely DT"   ItemStyle-Wrap="false" HeaderStyle-Wrap="false" ReadOnly="True" DataField="dock_cdeldt"/>
<asp:BoundColumn ItemStyle-BackColor="white" HeaderText="Chrg Wt./Freight" ReadOnly="True"  ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false"  DataField="FRT_chrg_RATE" />

<asp:BoundColumn ItemStyle-BackColor="white" HeaderText="Frt. Rate(per Kg/Pkg)" ReadOnly="True"  ItemStyle-Wrap="true"    ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false"  DataField="FRT_RATE" />

<asp:BoundColumn ItemStyle-BackColor="white" HeaderText="Docket Charges" ReadOnly="True"   ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false" DataField="dktchg"/>

<asp:BoundColumn ItemStyle-BackColor="white" HeaderText="FOV Charges" ReadOnly="True"  HeaderStyle-Wrap="false"  ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" DataField="FOV"/>
<asp:BoundColumn ItemStyle-BackColor="white" HeaderText="Other Charges" ReadOnly="True"  ItemStyle-Wrap="false"   ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false" DataField="otchg"/>
<asp:BoundColumn ItemStyle-BackColor="white" HeaderText=" Service Tax" ReadOnly="True"   ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false" DataField="SVCTAX"/>
 
 <asp:TemplateColumn  ItemStyle-BackColor="white"  HeaderText="Docket Total" HeaderStyle-Wrap="false" HeaderStyle-CssClass="" ItemStyle-HorizontalAlign="Right">
	 <headertemplate>Docket Total </headertemplate>
	 <HeaderStyle  CssClass="blackfnt" Font-Bold="false"/>
                <ItemTemplate>
                     
                    <asp:Label CssClass="blackfnt" ID="dktamt"   text ='<%# DataBinder.Eval(Container.DataItem,"dkttot") %>'   runat="server" >
                     
                    </asp:Label>
                    <asp:HiddenField ID="hdndt" runat="server" Value=<%# DataBinder.Eval(Container.DataItem,"dockdt") %> ></asp:HiddenField>
                    <asp:HiddenField ID="Hnd_Dkttot" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"dkttot") %>' ></asp:HiddenField>
                    </center>
                </ItemTemplate>
                <FooterStyle CssClass="Blackfnt" />
                <FooterTemplate >
                   
                
                    <asp:Label CssClass="blackfnt" ID="dktamt_final"   text =''   runat="server" >
                    </asp:Label>
                    </center>
                </FooterTemplate>
     </asp:TemplateColumn>

   
     </Columns>
       
   
    </asp:DataGrid>
    </td>
    </tr>
    <tr bgcolor="white">
    <td align="center" valign="middle">
    <br />
    <asp:HiddenField ID="txtdocketlist" runat="server" />
       <asp:HiddenField ID="txtdocketlist_count" runat="server" />
       <asp:HiddenField ID="Hnd_Mindate" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_Maxdate" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_Server_dt" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_BillGen_Loc_BasedOn" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_ON_CR_Limit_Allow" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_OutStd_Limit_Allow" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_manual_billno_Mandatory" runat="server"   ></asp:HiddenField>
        <asp:HiddenField ID="Hnd_Duplicate_check" runat="server"   ></asp:HiddenField>
        
        
       <asp:HiddenField ID="Hnd_AlloW_BackDate" runat="server"   ></asp:HiddenField>
       <p> <center> <asp:Button ID="Button1" runat="server"    OnClientClick="javascript:return OnSubmit(this)"  CssClass="blackfnt" Text="Click Here to GENERATE BILL for checked Dockets"  OnClick="Button1_Click"/></center></p>
       
    </td>
    </tr>
        </table>
     <br />
 
 

    <br />
    <br />
    
     <p></p>
       
        </td>
        </tr>
       </table>
       
       </div>
       
        <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV></asp:Content>
      
<%--    </form>
</body>
</html>--%>
