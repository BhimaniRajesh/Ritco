<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" Trace="true" CodeFile="docketoperationedit.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_docketoperationedit"   %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">--%>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <%-- <script language="javascript" type="text/javascript" src="docket_javascript.js"></script>--%>
    <script language="javascript" type="text/javascript" >

// validating emptyCheck    
    function validateFields()
    {
        var docno=document.getElementById("ctl00_MyCPH1_dockno");
        if(docno=="")
        {
            alert("Enter Docket Number Properly....");
            return false;
        }
    }
    
    
// this function assignment in keypress doesn't allow any character other than number.
function validInt(event)
{
    if(event.keyCode==13)
        {
            return true;
        }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}


// this function assignment in keypress doesn't allow any character other than number and a dot.
function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
        return true;
        
         if(event.keyCode==46)
          if(txt.indexOf('.')!=-1)
            event.keyCode=0;
        
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
        {
        event.keyCode=0;
        return false;
        }
}


    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	var dktlenght="<%=dktlenght%>"
	function OnDocketlenghtcheck(obj)
	{
		dktno=obj.value
		if(obj.value!="")
		{
			if(dktno.length<dktlenght)
			{
					alert("CN Number Length should be "+dktlenght+" digit !!!")
					obj.focus();
					return false;
			}
		}
	}
    </script>
    <div>
    
    <table style="width:9.5in;" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><a href="../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Operation</strong></font>    </a> 
   
   &gt; <font class="bluefnt"><strong>  
		 <%=sdkt_call %> Edit
		   
		  </strong> </font>
   </td></tr>
     <tr> 
          <td><img alt="" src="../../images/clear.gif" width="15" height="10" /></td>
        </tr>

        <tr> 
          <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img alt="" src="../../images/back.gif" border="0" /></a></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr><td>
   
        <table  width="100%" border="0" cellspacing="0" cellpadding="0" >
        <asp:HiddenField  ID="DocketMode"  runat="server" />
        <tr>
            
             <td>
             
                <table  border="0" cellpadding="0" cellspacing="0" style="width:100%"  >
                <tr>
                    <td>
                         <p><font class="blackfnt"><b><u>Note :</u></b> Fields marked with <font class="blackfnt" color="red"><b>'*'</b></font> are compulsory.</font></p>
                    </td>
                </tr>
                <tr>
                    <td>
                    <asp:UpdatePanel  ID="paydetal_error" runat="server">
                    <ContentTemplate>
                <asp:Label ID="Payment_detal_errmsg1" Text=""  runat="server"   CssClass="blackfnt" ForeColor="red"></asp:Label>
                </ContentTemplate>
                </asp:UpdatePanel>
                 </td>
                </tr>
                </table>
                <br />
                
                <asp:UpdatePanel  ID="UpdatePanel3" runat="server">
                    <ContentTemplate>

<%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                             THIS TABLE GETS LOCATION AND BILLING PARTY INFOR                    
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=--%>
                   <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
                        <tr> 
                            <td colspan="6" align="center" class="bgbluegrey"><font class="blackfnt"><b><%=sdkt_call %> Detail </b></font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                         <td style="height: 24px" class="blackfnt">
                             <font class="redfnt">*</font><asp:Label ID="lbldocklabel" runat="server"></asp:Label>
                         </td>
                        <td style="height: 24px" >
                             <asp:UpdatePanel ID="checkdockno" runat="server">
                               <ContentTemplate>
                                     <asp:TextBox ID="dockno" style="display:none;" CssClass="blackfnt" TabIndex="1" onblur="return OnDocketlenghtcheck(this)" OnTextChanged="txtdocknocheck_TextChanged"  AutoPostBack="true" class="input"  runat="server" Columns="10"></asp:TextBox>
                                     <asp:Label CssClass="bluefnt" Font-Bold="true" ID="lbldockno" runat="server"></asp:Label>
                                     <asp:Label CssClass="blackfnt" ID="lblErrordockno" runat="server" style="color: Red;" visible="false"></asp:Label>
                                     <asp:HiddenField ID="validation_chk" runat="server" />
                               </ContentTemplate>
                              <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="dockno" EventName="TextChanged" />
                              </Triggers>
                           </asp:UpdatePanel>
                        </td>
                        <td style="height: 24px" ><font class="redfnt">*</font><font class="blackfnt"><%=sdkt_call %> Date </font>
                        </td>
                        <td style="height: 24px" > <asp:TextBox ID="dockdt" TabIndex="1"  CssClass="input"   runat="server" Width="55" MaxLength="10"> </asp:TextBox>
                          <a href="#"  onclick="cal.select(ctl00$MyCPH1$dockdt,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="anchor1" ><img alt="" src="../../images/calendar.jpg" border="0" /> 
                          </a>
                        </td>
                        <td style="height: 24px" class="blackfnt">
                            <font class="redfnt">*</font>Payment Type
                        </td>
                        <td style="height: 24px">
                            <asp:DropDownList ID="paybas" AutoPostBack="true" onchange="javascript:return partyEnable()"  runat="server">
                            </asp:DropDownList>
                        </td>
                   </tr> 
                   <tr bgcolor="#FFFFFF">
                         <td style="height: 24px"><font class="blackfnt">Billing Party </font>
                         </td>
                         <td style="height: 24px" >
                          <asp:UpdatePanel ID="Partydetail" runat="server">
	                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="consignor_Bill" OnTextChanged="onBlur_party" AutoPostBack="true" runat="server" Columns="8"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="consignor_Bill_name" AutoPostBack="true" runat="server" Columns="15"></asp:TextBox>&nbsp;
                                            <asp:Label ID="lblcontract_check" Text=""  runat="server"   CssClass="blackfnt" ForeColor="red"></asp:Label>
                                        </td>
                                        <td>
                                            <input id="btnPopUp" type="button" style="display: none;" value="..." name="custpup12"  runat="server" />                                        
                                        </td>
                                    </tr>
                                </table>
                              </ContentTemplate>
                              <Triggers>
                                   <asp:AsyncPostBackTrigger ControlID="consignor_Bill" EventName="TextChanged" />
                              </Triggers>
	                         </asp:UpdatePanel>  
                         </td>
                         <td style="height: 24px" ><font class="blackfnt">Origin </font></td>
                         <td style="height: 24px" >
                            <font class="bluefnt"> <%=Session["Brcd"].ToString() + ":" + branchname%>
                                <asp:HiddenField ID="Orgn" runat="server"  />
                            </font>
                         </td>
                         <td style="height: 24px" class="blackfnt">
                            <font class="redfnt">*</font>Delivery Control Location 
                         </td>
                          <td style="height: 24px"> 
                                <asp:UpdatePanel ID="state_documentdetail" runat="server">
	                                   <ContentTemplate>
	                                   <asp:TextBox ID="destn" CssClass="input" OnTextChanged="state_documentdetail_chk" AutoPostBack="true" runat="server" Columns="2" MaxLength="10"></asp:TextBox>
	                                   <input id="btnPopupLoc" type="button" value="..." name="custpup12" runat="server" />
	                                   </ContentTemplate>
	                            </asp:UpdatePanel>   
	                     </td>
                   </tr>
                   <tr  bgcolor="#FFFFFF" >
                         <td style="height: 24px" class="blackfnt"><font class="redfnt">*</font>Pickup/Delivery 
                         </td>
                         <td style="height: 24px" >
                                <asp:DropDownList ID="cboPickupDely" runat="server" >
                                <asp:ListItem Value='1'>Godown Pickup - Godown Delivery </asp:ListItem>
                                 <asp:ListItem Value='2'>Godown Pickup - Door Delivery</asp:ListItem>
                                  <asp:ListItem Value='3'>Door Pickup - Door Delivery</asp:ListItem>
                                   <asp:ListItem Value='4'>Door Pickup - Godown Delivery</asp:ListItem>
                                </asp:DropDownList>
                         </td>
                         <td style="height: 24px" class="blackfnt">From </td>
                         <td style="height: 24px" ><asp:UpdatePanel ID="Fromlocation" runat="server">
	                            <ContentTemplate> 
	                            <asp:TextBox ID="destfrom" runat="server" Columns="12" OnTextChanged="fOnChangepaybas_for_otherControl"></asp:TextBox>
	                            <input id="btnFrom" type="button" value="..." name="custpup12" runat="server" />
                         </ContentTemplate>
	                        </asp:UpdatePanel></td>
                         <td style="height: 24px"><font class="blackfnt">To </font>
                         </td>
                        <td style="height: 24px"> <asp:UpdatePanel ID="Tolocation" runat="server">
	                            <ContentTemplate>
	                            <asp:TextBox ID="destto" runat="server" Columns="12" OnTextChanged="fOnChangepaybas_for_otherControl"></asp:TextBox>
	                            <input id="btnTo" type="button" value="..." name="custpup12" runat="server" />
	                            </ContentTemplate>
	                        </asp:UpdatePanel>  </td>
                   </tr>
                   <tr bgcolor="#FFFFFF">
                   <td class="blackfnt">Volumetric</td>
                   <td>  
                        <asp:UpdatePanel ID="UpdatePanel11" runat="server">
	                         <ContentTemplate>
    	                          <asp:CheckBox id="chkcft" runat="server" OnCheckedChanged="NOOFROWS"  AutoPostBack="true" />
	                         </ContentTemplate>
	                    </asp:UpdatePanel>   
	               </td>
                   <td class="blackfnt">COD/DOD</td>
                   <td>
                       <asp:UpdatePanel ID="coddod" runat="server">
	                       <ContentTemplate>
	                            <asp:CheckBox id="chkCoddoc" runat="server" AutoPostBack="true"  OnCheckedChanged="fOnChangepaybas"  />
	                        </ContentTemplate>
	                    </asp:UpdatePanel>   
	               </td>
                   <td class="blackfnt">ODA</font></td>
                   <td><asp:UpdatePanel ID="UpdatePanel13" runat="server">
	                            <ContentTemplate><asp:CheckBox id="chkoda" runat="server"  Enabled="false"   AutoPostBack="true"  />
	                            </ContentTemplate>
	                        </asp:UpdatePanel>   </td>
                   </tr>
                   <tr  bgcolor="#FFFFFF">
                   <td class="blackfnt">Local <%=sdkt_call %></td>
                   <td> 
                       <asp:CheckBox id="local_yn"  runat="server"  />
                   </td>
                   <td></td>
                   <td></td>
                   <td></td>
                   <td></td>
                   </tr>
                   </table>
                   </ContentTemplate>
                   </asp:UpdatePanel>               
                  
                   
<br /><br />


<%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                             THIS TABLE GETS CONSIGNOR AND COSIGNEE DETAILS                    
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>


                    <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
                    <tr class="bgbluegrey" > 
                        <td class="bgbluegrey" ></td>
                        <td align="center" class="bgbluegrey"><font class="blackfnt"><b>Consignor</b></font></td>
                        <td align="center" class="bgbluegrey"><font class="blackfnt"><b>Consignee</b></font></td>
                         <td colspan="3" align="center" class="bgbluegrey"><font class="blackfnt"><b>Document</b></font> </td>
                     
                    </tr>
                     <tr bgcolor="#FFFFFF"> 
                        <td style="height: 53px" class="blackfnt">Code</td>
                                         <td align="left" class="blackfnt" style="height: 53px;">
                                         <font class="redfnt"><b>*</b></font>Enter from existing Consignor<br />
                                <asp:UpdatePanel ID="UpdatePanel8" runat="server">
	                            <ContentTemplate>
                                    <asp:TextBox  TabIndex="1"  ID="consignor_name_B" class="input" runat="server" Columns="8" AutoPostBack="true"  OnTextChanged="partynamedisplay" ></asp:TextBox>
                                   
                                    <asp:TextBox   TabIndex="1" class="input"  ID="consignor_name_B_nm" runat="server" Columns="15" AutoPostBack="true"></asp:TextBox > 
                                      <asp:Button  TabIndex="1" Text="..." runat="server" ID="btn1"  />
                                    </ContentTemplate>
                                      <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="consignor_name_B" EventName="TextChanged" />
                                   </Triggers>
                                   
                                  </asp:UpdatePanel>   
                                  </td>
                                      
                                <td align="left" class="blackfnt" style="height: 53px;">
                                             <font class="redfnt"><b>*</b></font>Enter from existing Consignee<br />
                                       <asp:UpdatePanel ID="UpdatePanel9" runat="server">
	                            <ContentTemplate>
                                      <asp:TextBox ID="consignee_name_B" TabIndex="2"  class="input" runat="server" Columns="10" AutoPostBack="true" OnTextChanged="cagenamedisplay"></asp:TextBox>
                                      <asp:TextBox  class="input"  TabIndex="2" ID="consignee_name_B_nm" runat="server" Columns="15"  AutoPostBack="true">
                                      </asp:TextBox ><asp:Button runat="server" Text="..." TabIndex="2" ID="Btn2"/>
                                       </ContentTemplate>
                                      <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="consignee_name_B" EventName="TextChanged" />
                                   </Triggers>
                                   
                                  </asp:UpdatePanel>   
                                      </td>
                        <td align="left" style="height: 53px;"><font class="blackfnt">Risk Type </font></td>
                        <td colspan="2" align="left" style="height: 53px">
                       
                    <asp:RadioButtonList ID="ins" TabIndex="3" CssClass="blackfnt" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem value="C" Selected="True">Carrier's Risk</asp:ListItem>
                        <asp:ListItem  Value="O">Owner's Risk</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                      
                    </tr>
                    <tr bgcolor="#FFFFFF"> 
                        <td colspan="3" align="center"><font class="blackfnt"><b>New </b>&nbsp;</font> </td>
                        <td align="left" class="blackfnt">Policy No &amp; Date</td>
                        <td align="left" colspan="2">
                            <table width="100%">
                                <tr>
                                    <td align="left">
                                        <asp:TextBox ID="policyno" TabIndex="3" runat="server" Columns="10"></asp:TextBox>
                                        <asp:TextBox ID="txtinsdt" TabIndex="3" runat="server" Columns="10"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtinsdt,'anchor11','dd/MM/yyyy'); return false;"  name="anchor11" id="a2" ><img alt="" src="../../images/calendar.jpg" border="0" /> 
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                      
                    </tr>
                    <tr bgcolor="#FFFFFF"> 
                        <td align="left"><font class="blackfnt"><b><font class="redfnt">*</font>Name </b>&nbsp;</font> </td>
                        <td align="left"><asp:TextBox  TabIndex="1"  ID="consignor_name"  onblur="this.value=this.value.toUpperCase()"  CssClass="input"  runat="server" Columns="30"></asp:TextBox></td>
                        <td align="left"><asp:TextBox ID="consignee_name" TabIndex="2" onblur="this.value=this.value.toUpperCase()" CssClass="input"  runat="server" Columns="30"></asp:TextBox></td>
                        <td align="left"><font class="blackfnt">Internal covers  </font> </td>
                        <td align="left" colspan="2">
                            <table>
                                <tr>
                                    <td align="left">
                                        <asp:CheckBox Visible="false" ID="chk1" TabIndex="3" runat="server" />
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="covers" TabIndex="3" runat="server" Columns="10"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><font class="redfnt">*</font> Address</font></td>
                            <td align="left">
                                <asp:TextBox ID="consignor_add" TabIndex="1" CssClass="input"  onblur="this.value=this.value.toUpperCase()" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                            <td align="left">
                                <asp:TextBox ID="consignee_add" TabIndex="2" CssClass="input"  onblur="this.value=this.value.toUpperCase()"  runat="server" TextMode="MultiLine"></asp:TextBox></td>
                            <td class="blackfnt" align="left">Modvat covers </td>
                            <td align="left" colspan="2">
                                <table width="100%">
                                    <tr>
                                        <td align="left">
                                           <asp:CheckBox ID="modvat" TabIndex="3" runat="server" /> <asp:TextBox ID="totmodvat" runat="server" TabIndex="3" Columns="10"></asp:TextBox>
                                       </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                                <font class="blackfnt"><font class="redfnt">*</font>City - Pincode</font></td>
                            <td align="left">
                                <asp:TextBox ID="consignor_city" TabIndex="1" onblur="this.value=this.value.toUpperCase()" CssClass="input"  runat="server"></asp:TextBox>-<asp:TextBox ID="consignor_pin"
                                  TabIndex="1" onkeypress="javascript:return validInt(event)"  CssClass="input"  MaxLength="6"  runat="server" Columns="5"></asp:TextBox></td>
                            <td  align="left">
                                <asp:TextBox ID="consignee_city" TabIndex="2" onblur="this.value=this.value.toUpperCase()" CssClass="input"  runat="server"></asp:TextBox>-<asp:TextBox ID="consignee_pin"
                                    TabIndex="2" onkeypress="javascript:return validInt(event)" CssClass="input" MaxLength="6" runat="server" Columns="5"></asp:TextBox></td>
                            <td align="left">
                               <font class="blackfnt"> Customer ref.</font></td>
                            <td align="left">
                                <asp:TextBox ID="ctrno" TabIndex="3" runat="server" Columns="15"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left">
                              <font class="blackfnt"><font class="redfnt">*</font>Telephone</font></td>
                            <td style="height: 26px;">
                                <asp:TextBox ID="consignor_telno" onkeypress="javascript:return validInt(event)" CssClass="input" TabIndex="1" runat="server"></asp:TextBox></td>
                            <td align="left" style="height: 26px;">
                                <asp:TextBox ID="consignee_telno" onkeypress="javascript:return validInt(event)" CssClass="input" TabIndex="2" runat="server"></asp:TextBox></td>
                            <td align="left" style="height: 26px;">
                              <font class="blackfnt">  Private mark</font></td>
                            <td colspan="2" align="left" style="height: 26px">
                                <asp:TextBox ID="txtprivatemark" TabIndex="3" runat="server" Columns="15"></asp:TextBox></td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td align="left" style="height: 26px">
                               <font class="blackfnt"> Email</font></td>
                            <td align="left" style="height: 26px;">
                                <asp:TextBox ID="consignor_email" TabIndex="1" runat="server" Columns="30"></asp:TextBox></td>
                            <td style="height: 26px;">
                                <asp:TextBox ID="consignee_email" TabIndex="2" runat="server" Columns="30"></asp:TextBox></td>
                            <td align="left" style="height: 26px;">
                               <font class="blackfnt"> TP Number</font></td>
                            <td align="left" style="height: 26px" colspan="2">
                                <asp:TextBox ID="txttpno" TabIndex="3" runat="server" Columns="15"></asp:TextBox></td>
                        </tr>
                    </table>
                    <p>
                    </p>
                    
            <asp:UpdatePanel ID="state_docdetail" runat="server">
                <ContentTemplate>
                   
                                                                

<%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS GRID GETS DOCUMENT DETAILS                   
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>


                    <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
                            <tr id="state_doc_table" runat="server" visible="false"> 
                                    <td colspan="4" align="center" class="bgbluegrey"><font class="blackfnt"><b>Document Details </b></font></td>
                            </tr>
                        <tr bgcolor="#FFFFFF">
                            <td colspan="4">
                            <asp:GridView ID="rptDocketList" align="center" runat="server" AutoGenerateColumns="False" Width="100%" 
                                    Style="text-align: left" CssClass="blackfnt" Visible="true" DataKeyField="dockno" >
                                    <AlternatingRowStyle BackColor="#EEEEEE" CssClass="blackfnt"  />
                                    <HeaderStyle CssClass="bgbluegrey"  />
                        <Columns>
                            <asp:TemplateField HeaderText="Document Name" HeaderStyle-CssClass="blackfnt"  HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate><center>
                                    <asp:Label CssClass="blackfnt"  ID="STFORM"   text ='<%# DataBinder.Eval(Container.DataItem,"STFORM") %>'   runat="server" ></asp:Label>
                                </center></ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt"  HeaderStyle-HorizontalAlign="Center">
                                 <ItemTemplate><center>
                                     <asp:Label CssClass="blackfnt"  ID="STCSTREQ"   text ='<%# DataBinder.Eval(Container.DataItem,"STCSTREQ") %>'   runat="server" ></asp:Label>
                                 </center></ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"  HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate><center>
                                    <asp:Label CssClass="blackfnt"  ID="STNM"   text ='<%# DataBinder.Eval(Container.DataItem,"STNM") %>' runat="server" ></asp:Label>
                                </center></ItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                                 <HeaderTemplate><asp:Label ID="Declared_Value1" CssClass="blackfnt" Text="Enclosed Document Number" runat="server" ></asp:Label></HeaderTemplate>
                                    <ItemTemplate><center>
                                          <asp:TextBox   ID ="docu" runat="server" MaxLength="20" Columns="12"  CssClass="input" Text=""></asp:TextBox>
                                          <asp:HiddenField  ID="Doc_srno"  runat="server"  Value='<%# DataBinder.Eval(Container.DataItem,"Doc_srno") %>' />
                                    </center></ItemTemplate>
                            </asp:TemplateField>
                      </Columns>
                 </asp:GridView>
                   </td></tr>
                </table>
                    </ContentTemplate>
                    <Triggers>
                             <asp:AsyncPostBackTrigger ControlID="destn"  EventName="TextChanged"  />
                   </Triggers>
              </asp:UpdatePanel>
              <p></p>
              
              
                                                               

<%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS TABLE SHOWS PERMIT TRACKER                
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>


                    <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
                     <tr class="bgbluegrey"> 
                         <td colspan="6" align="center" class="blackfnt">
                                <b>Permit Tracker </b>
                         </td>
                     </tr>
                     <tr bgcolor="#FFFFFF">
                         <td class="blackfnt">Permit Applicable</td>
                         <td>
                             <input id="txtpermit_yn" class="input" name="txtpermit_yn" type="hidden" size="9" value="No" onfocus="this.blur()"  runat="server" /><asp:CheckBox ID="permit_yn" runat="server" Columns="15" /></td>
                         <td class="blackfnt">Permit Received At</td>
                         <td>  
                                 <asp:DropDownList  ID="permit_recvd_at" runat="server">
                                     <asp:ListItem Value="">Select</asp:ListItem>
                                     <asp:ListItem Value="B">Booking</asp:ListItem>
                                     <asp:ListItem Value="D">Delivery</asp:ListItem>
                                     <asp:ListItem Value="C">Check Post</asp:ListItem>
                                 </asp:DropDownList>
                         </td>
                         <td class="blackfnt">Permit No.</td>
                         <td>
                            <asp:TextBox ID="permitno" runat="server" Columns="15"></asp:TextBox>
                         </td>
                     </tr>
                     <tr bgcolor="#FFFFFF" >
                         <td class="blackfnt">Permit Date</td>
                         <td>
                            <asp:TextBox ID="permitdt" runat="server" Columns="15"></asp:TextBox> 
                            <a href="#"  onclick="cal.select(ctl00$MyCPH1$permitdt,'anchor12','dd/MM/yyyy'); return false;"  name="anchor12" id="a3" ><img alt="" src="../../images/calendar.jpg" border="0" /> 
                            </a>
                         </td>
                         <td class="blackfnt">Permit Validity Date</td>
                         <td>
                            <asp:TextBox ID="permit_val_dt" runat="server" Columns="15"></asp:TextBox> 
                            <a href="#"  onclick="cal.select(ctl00$MyCPH1$permit_val_dt,'anchor13','dd/MM/yyyy'); return false;"  name="anchor13" id="a4" ><img alt="" src="../../images/calendar.jpg" border="0" /> 
                            </a>
                         </td>
                         <td class="blackfnt">Permit Received Date</td>
                         <td>
                            <asp:TextBox ID="permit_recvd_dt" runat="server" Columns="15"></asp:TextBox> 
                            <a href="#"  onclick="cal.select(ctl00$MyCPH1$permit_recvd_dt,'anchor14','dd/MM/yyyy'); return false;"  name="anchor14" id="a5" ><img alt="" src="../../images/calendar.jpg" border="0" /> 
                            </a>
                         </td>
                   </tr>
              </table>
              <p></p>
                                                                       

<%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS TABLE SHOWS PERMIT TRACKER                
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>


                <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
                     <tr> 
                        <td colspan="9" align="center" class="bgbluegrey">
                           <input id="cltotdoc" name="cltotdoc"  type="hidden" runat="server" />
                           <font class="blackfnt"><b>Invoice Details </b></font>
                         </td>
                     </tr>
                     <tr bgcolor="#FFFFFF">
                          <td colspan="2" align="right" class="blackfnt">
                              <b>Enter No Of Rows</b>
                          </td>
                          <td colspan="7" align="left" ><font class="blackfnt"><b>
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                    <asp:TextBox  ID="noofrows1" TabIndex="1" onblur="rowBlur(this.getAttribute('id'))" OnTextChanged="NOOFROWS" onkeypress="javascript:validInt(event)" Columns="5" AutoPostBack="true" runat="server" > </asp:TextBox>
                                     </ContentTemplate>
                                     </asp:UpdatePanel>
                                     </b></font></td>
                     </tr>
                     <tr  bgcolor="#FFFFFF">
                        <td colspan="9">
              <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                
                        <asp:GridView ID="invdata" align="center" runat="server" AutoGenerateColumns="False" Width="100%" 
                                    Style="text-align: left" CssClass="blackfnt" OnRowDataBound="invdata_RowDataBound" Visible="true" DataKeyField="dockno" >
                                    <AlternatingRowStyle BackColor="#EEEEEE" CssClass="blackfnt"  />
                                    <HeaderStyle CssClass="bgbluegrey"  />
                        <Columns>
                        <asp:TemplateField HeaderText="SRNO" HeaderStyle-CssClass="blackfnt"  HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <center>
                            <asp:Label CssClass="blackfnt" ID="SRNO" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                            </center>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                              <HeaderTemplate>
                                <asp:Label ID="lblinvstarno" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                <asp:Label ID="InvoiceNo" CssClass="blackfnt" Text="Invoice No." runat="server"  ></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                         <asp:TextBox ID="invno" runat="server" TabIndex="1" MaxLength="20" Columns="10" CssClass="input"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                 <asp:Label ID="lblinvstardate" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                 <asp:Label ID="Invoice_Date" TabIndex="1" CssClass="blackfnt" Text="Invoice Date" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID="invdt" TabIndex="1" runat="server" MaxLength="10" Columns="10" CssClass="input"  ></asp:TextBox>
                                       <asp:LinkButton ID="lnkdate" runat="server">
                                       <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                        </asp:LinkButton>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate >
                                    <asp:Label ID="lblinvstardelval" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                    <asp:Label ID="Declared_Value" CssClass="blackfnt" onkeypress="javascript:validInt(event)" Text="Declared Value" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID ="declvalue" TabIndex="1" runat="server" onkeypress="javascript:validInt(event)" MaxLength="10" Columns="8"  CssClass="inputnum" Text="0.00"></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                        <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                    <asp:Label ID="lblinvstarpkgsno" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                    <asp:Label ID="No_of_Pkgs" CssClass="blackfnt" onkeypress="javascript:validInt(event)" Text="No. of Pkgs." runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                     <asp:TextBox ID="pkgno" TabIndex="1" runat="server" MaxLength="10" Columns="8"  Text="0" CssClass="input" ></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField  HeaderStyle-HorizontalAlign="Center"  AccessibleHeaderText="actwt_test" Visible="true">
                             <HeaderTemplate> 
                                    <asp:Label ID="lblinvstaractwt" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                    <asp:Label ID="Actual_Weight" TabIndex="1" CssClass="blackfnt" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Text="Actual Weight" runat="server"  ></asp:Label>
                            </HeaderTemplate >
                            <ItemTemplate>
                                <center>
                                      <asp:TextBox ID="actwt" TabIndex="1" runat="server" MaxLength="10" Columns="8"  Text="0.00" CssClass="inputnum"></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                      </Columns>
                        </asp:GridView>
                        
                        
                        <asp:GridView ID="invdata_cft" align="center" runat="server" AutoGenerateColumns="False" Width="100%" 
                                    Style="text-align: left" CssClass="blackfnt" OnRowDataBound="invdata_cft_RowDataBound" Visible="true" DataKeyField="dockno" >
                                    <AlternatingRowStyle BackColor="#EEEEEE" CssClass="blackfnt"  />
                                    <HeaderStyle CssClass="bgbluegrey"  />
                        <Columns>
                        <asp:TemplateField HeaderText="SRNO" HeaderStyle-CssClass="blackfnt"  HeaderStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <center>
                            <asp:Label CssClass="blackfnt"  ID="SRNO" text='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>'  runat="server" >
                           </asp:Label>
                            </center>
                        </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                              <HeaderTemplate>
                              <asp:Label ID="InvoiceNo" CssClass="blackfnt" Text="Invoice No." runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                          <asp:TextBox ID="invno" runat="server" MaxLength="20" Columns="12" CssClass="input" ></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                     </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate >
                                 <asp:Label ID="Invoice_Date" CssClass="blackfnt" Text="Invoice Date" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID ="invdt" MaxLength="10" Columns="10" CssClass="input" runat="server"></asp:TextBox>
                                       <asp:LinkButton ID="lnkdate" runat="server">
                                            <img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                       </asp:LinkButton>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate >
                                 <asp:Label ID="Declared_Value" CssClass="blackfnt" Text="Declared Value" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                      <asp:TextBox ID="declvalue" runat="server" MaxLength="8" Columns="8"  CssClass="inputnum" Text="0.00"></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                        <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                 <asp:Label ID="No_of_Pkgs" CssClass="blackfnt" Text="No. of Pkgs." runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                      <asp:TextBox ID="pkgno" runat="server" MaxLength="8" Columns="8"  Text="0" CssClass="inputnum" ></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                 <asp:Label ID="Length1" CssClass="blackfnt" Text="Length" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID="length" runat="server" MaxLength="5" Columns="5" Text="0.00" CssClass="inputnum" ></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                 <asp:Label ID="Breadth1" CssClass="blackfnt" Text="Breadth" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID="breadth" runat="server" MaxLength="5" Columns="5"  Text="0.00" CssClass="inputnum" ></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                 <asp:Label ID="height1" CssClass="blackfnt" Text="height" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID="height" runat="server" MaxLength="5" Columns="5"  Text="0.00" CssClass="inputnum" ></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField  HeaderStyle-HorizontalAlign="Center">
                             <HeaderTemplate>
                                 <asp:Label ID="cubicfit" CssClass="blackfnt" Text="Total" runat="server" ></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                       <asp:TextBox ID="cftval" runat="server" MaxLength="5" Columns="5"  ReadOnly="true" Text="0.00" CssClass="inputnum"></asp:TextBox>
                                </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField  HeaderStyle-HorizontalAlign="Center"  AccessibleHeaderText="actwt_test" Visible="true">
                             <HeaderTemplate>
                                 <asp:Label ID="Actual_Weight" CssClass="blackfnt" Text="Actual Weight" runat="server"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center>
                                      <asp:TextBox ID ="actwt" runat="server" MaxLength="8" Columns="8"  Text="0.00" CssClass="inputnum"></asp:TextBox>
                               </center>
                            </ItemTemplate>
                    </asp:TemplateField>
                      </Columns>
                   </asp:GridView>
                </ContentTemplate>
                    <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="noofrows1" EventName="TextChanged"  />
                          <asp:AsyncPostBackTrigger ControlID="chkcft" EventName="CheckedChanged"  />
                   </Triggers>
              </asp:UpdatePanel>
              </td>
              </tr>
              <tr bgcolor="#ffffff">
                  <td colspan="9">
                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                        <ContentTemplate>
                        <table border="1" cellpadding="3" cellspacing="0" bgcolor="#999999" style="width:100%" id="cft_detal_row" runat="server" visible="false">
                             <tr bgcolor="#ffffff">
                                <td class="blackfnt">
                                    <font class="redfnt" color="red"><b> * </b></font>Cubic ft. Conversion ratio
                                </td>
                                <td><font class="bluefnt">1 Cubic ft. = <asp:TextBox runat="server" ID="cftratio" Columns="5" onkeypress="validFloat(event,this.getAttribute('id'))" MaxLength="5"></asp:TextBox> Kg.</font></td>
                                <td><font class="blackfnt"><font class="black" color="red"><b> * </b></font>Total Cubic ft.</font></td>
                                <td><asp:TextBox runat="server" style="" ID="total_cft" Columns="5" onkeypress="validFloat(event,this.getAttribute('id'))" MaxLength="5" ></asp:TextBox></td>
                             </tr>
                        </table>
              </ContentTemplate>
              </asp:UpdatePanel>
                   </td>
              </tr>
               </table>
                    <p></p>
                    
        <asp:UpdatePanel ID="updt_service" runat="server">
            <ContentTemplate>
                                                                                

<%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS TABLE SHOWS CONSIGNMENT DETAILS             
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>
            <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
                 <tr> 
                      <td colspan="6" align="center" class="bgbluegrey"><font class="blackfnt"><b>Consignment Details </b></font></td>
                 </tr>
                 <tr  bgcolor="#ffffff">
                     <td class="blackfnt" style="height: 26px; width: 180px;">Total Declare Value</td>
                     <td style="height: 26px; width: 116px;">
                             <asp:TextBox ID="decl" Enabled="false" class="inputnum" Text="0.00"  runat="server" Columns="5" ></asp:TextBox>
                     </td>
                     <td style="height: 26px; width: 191px;">&nbsp;</td>
                     <td style="height: 26px" colspan="3"></td>
                 
                 </tr  >
                 <tr  bgcolor="#ffffff">
                 
                 <td style="height: 26px; width: 180px;">
                     <font class="blackfnt">Total No. of packages</font></td>
                 <td style="height: 26px; width: 116px;">
                     <asp:TextBox ID="pkg" Enabled="false"  class="input" Text="0" CssClass="inputnum" runat="server" Columns="5"  ></asp:TextBox>
                 </td>
                 <td style="height: 26px; width: 191px;">
                    <font class="blackfnt"> <font class="redfnt">*</font> Packaging Type</font></td>
                 <td style="height: 26px" colspan="3"><asp:DropDownList  ID="pkgtyp" runat="server">
                     <asp:ListItem>Select</asp:ListItem>
                 </asp:DropDownList></td>
                 
                 </tr>
                 <tr bgcolor="#ffffff">
                     <td style="width: 180px" class="blackfnt">Total Actual weight (Kg.)</td>
                     <td style="width: 116px">
                         <asp:TextBox ID="awt" Enabled="false" class="inputnum" Text="0.00" runat="server" Columns="5"  ></asp:TextBox>
                      </td>
                      <td class="blackfnt" style="width: 191px"> <font class="redfnt">*</font> Said to contain (Product)</td>
                      <td colspan="3">
                            <asp:DropDownList  ID="prod" runat="server">
                                <asp:ListItem>Select</asp:ListItem>
                            </asp:DropDownList>
                      </td>
                 </tr>
                 <tr bgcolor="#ffffff" class="blackfnt">
                      <td style="width: 180px">
                             <font class="redfnt">*</font>Charged weight (Kg.)
                      </td>
                         <td style="width: 116px">
                             <asp:TextBox ID="cwt"  class="inputnum" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" runat="server" Columns="5"></asp:TextBox></td>
                         <td style="width: 191px">
                             <font class="blackfnt">Special Instructions</font></td>
                         <td colspan="3">
                             <asp:TextBox ID="spl_inst" runat="server" TextMode="MultiLine"></asp:TextBox>
                         </td>
                  </tr>
                  <tr bgcolor="#ffffff">
                             <td style="width: 180px">
                                <font class="blackfnt"> <font class="redfnt">*</font> Mode</font></td>
                             <td style="width: 116px">
                              
                              <asp:DropDownList  ID="trans" runat="server" Width="65px"  AutoPostBack="true" OnSelectedIndexChanged="fOnChangepaybas_for_otherControl">
                                 <asp:ListItem>Select</asp:ListItem>
                             </asp:DropDownList>
                            </td>
                             <td style="width: 191px">
                                 <font class="blackfnt"><font class="redfnt">*</font> Service Type</font></td>
                             <td colspan="2">
                                  <asp:UpdatePanel ID="updservice" runat="server">
                                    <ContentTemplate>
                                          <asp:DropDownList  ID="service" onchange="javascript:return enableBox()" runat="server" AutoPostBack="true" OnSelectedIndexChanged="fOnChangepaybas_for_otherControl">
                                          </asp:DropDownList>
                                  
                                <font class="blackfnt"><font class="redfnt">*</font>  Type of FTL</font></td>
                             <td> 
                                <asp:DropDownList  ID="service_ftl" runat="server"  OnSelectedIndexChanged="fOnChangepaybas_for_otherControl">
                                     <asp:ListItem>Select</asp:ListItem>
                                </asp:DropDownList>
                                </ContentTemplate>
                                  </asp:UpdatePanel>
                             </td>
                         </tr>
                         </table>
                        </ContentTemplate>
                     </asp:UpdatePanel>
             </td>
        </tr>
         </table>
         
          <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                           <ContentTemplate>
                                   <center> <p> 
                                   <asp:Label ID="Payment_detal_errmsg" Text=""  runat="server" CssClass="blackfnt" ForeColor="red"></asp:Label> 
                                  <%--  <asp:Button Text="Click here for Payment Detail" runat="server" ID="paymentdetail" OnClick="fOnChangepaybas" /></p>--%>
                                   </center>
             </ContentTemplate>
                 </asp:UpdatePanel>
                 
                         <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                <ContentTemplate>
                        
                    <table>
                        <tr>
                            <td>
                    <%--CHECKOUTS THE MODE OF ENTRY WHERE IT IS EDIT OR ADD TO DISTINGUISH --%>                            
                    <asp:HiddenField ID="hdnmode" Value="EDIT" runat="server" />

                    <asp:HiddenField ID="CHG_SCHG01" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG02" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG03" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG04" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG05" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG06" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG07" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG08" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG09" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG10" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG11" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG12" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG13" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG14" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG15" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG16" Value="0.00" runat="server" />
                    
                    <asp:HiddenField ID="CHG_SCHG17" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG18" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG19" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG20" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG21" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG22" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_SCHG23" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG01" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG02" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG03" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG04" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG05" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG06" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG07" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG08" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG09" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_UCHG10" Value="0.00" runat="server" />
                    <asp:HiddenField ID="CHG_FOV" Value="0.00" runat="server" />
                    <asp:HiddenField ID="Payment_detail_show" runat="server" Value="N" />
                    
                    <asp:HiddenField ID="min_pkgsno" runat="server" Value="0" />
                    <asp:HiddenField ID="min_frt" Value="0.00" runat="server"  />
                    <asp:HiddenField ID="min_chrgwt" Value="0.00" runat="server"  />
                    </td>
                    </tr>
                  </table>
                  
                   <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
			                                                                <%--#include file="./add_contract_charges.asp"--%>
			                                                                <%--Dynamically populate charges table in code behind--%>
			      <tr id="Payment_detal_table1" runat="server"> 
                                    <td colspan="6" align="center" class="bgbluegrey">
                                        <font class="blackfnt"><b> Payment Details </b></font>
                                    </td>
                  </tr>
			                                                                <tr bgcolor="#FFFFFF"  id="Payment_detal_table2" runat="server"> 
			                                                                    <td><font class="blackfnt">Service Tax Paid By</font></td>
			                                                                 <td> <asp:DropDownList  ID="staxpaidby" runat="server" Width="65px">
                                                                                     <asp:ListItem Value="">Select</asp:ListItem>
                                                                                     <asp:ListItem  Value="Billing party">Billing party</asp:ListItem>
                                                                                      <asp:ListItem  Value="Consignor">Consignor</asp:ListItem>
                                                                                       <asp:ListItem  Value="Consignee">Consignee</asp:ListItem>
                                                                                        <asp:ListItem  Value="Transporter">Transporter</asp:ListItem>
                                                                                 </asp:DropDownList>
                                                                             </td> 
			                                                                 <td><font class="blackfnt">Service Tax Reg. No.</font></td> 
			                                                                 <td> <asp:TextBox ID="staxregno"  Columns="10"  MaxLength="10" runat="server" ></asp:TextBox></td> 
			                                                                 <td><font class="blackfnt">Billed At</font></td> 
			                                                                 <td><asp:TextBox ID="fincmplbr"  Columns="2" CssClass="input"  MaxLength="10" runat="server" ></asp:TextBox> </td>
			                                                                </tr>
			                                                                <tr  bgcolor="#FFFFFF"  id="Payment_detal_table3" runat="server"> 
			                                                                 <td class="blackfnt">Freight charges</td>
			                                                                 <td>
			                                                                    <asp:TextBox ID="frieght"  Columns="8" CssClass="inputnum"  MaxLength="10" runat="server" ></asp:TextBox>
			                                                                 </td> 
			                                                                 <td>
			                                                                    <asp:DropDownList  ID="ratetype" runat="server" Width="65px">
                                                                                      <asp:ListItem value='W'>Rate/Kg</asp:ListItem>
                                                                                      <asp:ListItem value='P'>Rate/Pkg</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                             </td> 
			                                                                 <td>
			                                                                    <asp:TextBox ID="rate" Columns="8" CssClass="inputnum" MaxLength="10" runat="server" ></asp:TextBox>
			                                                                 </td> 
			                                                                 <td class="blackfnt">EDD</td>
			                                                                 <td>
			                                                                    <asp:TextBox ID="txtDelyDt" runat="server" Columns="8" CssClass="input"></asp:TextBox>
			                                                                    <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDelyDt,'anchor2','dd/MM/yyyy'); return false;"  name="anchor2" id="a1" ><img src="../../images/calendar.jpg" border="0" >
                                                                                </a>
                                                                            
			                                                                 </td>
			                                                                  </tr>
			                                                                <tr bgcolor="#FFFFFF" id="Payment_detal_table9" runat="server"> 
			                                                                <td  colspan="6"> 
			                                                                 <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
			                                                               
			                                                                <%=blnAppForFOVCharges %>
			                                                                <%=strContractCharges %>
			                                                                <%=strContractChargesHidden %>
			                                                               </table> 
			                                                              </td>
			                                                            </tr>
			                                                            <tr bgcolor="#FFFFFF" id="Payment_detal_table4" runat="server">
		                                                                    <td></td>
		                                                                    <td></td>
		                                                                    <td></td>
		                                                                    <td></td>
		                                                                    <td class="blackfnt">
		                                                                        <b>SUB-TOTAL</b>
		                                                                    </td>
		                                                                    <td>
		                                                                        <asp:TextBox ID="subtotal"  Columns="8" CssClass="inputnum"  MaxLength="10" runat="server"  Enabled="false" ></asp:TextBox>
		                                                                    </td>
			                                                            </tr>
			                                                            <tr bgcolor="#FFFFFF" id="Payment_detal_table5" runat="server">
		                                                                    <td><font class="blackfnt">Service Tax Rate %</font></td>
		                                                                    <td><font class="bluefnt"><%=ServiceTax %></font></td>
		                                                                    <td><font class="blackfnt">Service tax on sub-total</font></td>
  	                                                                        <td><asp:TextBox ID="stax" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Columns="8" CssClass="inputnum"  MaxLength="10" runat="server"   ReadOnly="true"></asp:TextBox></td>
		                                                                    <td><font class="blackfnt">Service tax- Collected</font></td>
		                                                                    <td><asp:TextBox ID="stax_s" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Columns="8" CssClass="inputnum"  MaxLength="10" runat="server" ></asp:TextBox></td>
			                                                            </tr>
			                                                            <tr bgcolor="#FFFFFF"  id="Payment_detal_table6" runat="server">
                                                                           <td><font class="blackfnt">Educational Cess Rate (%)</font></td>
                                                                           <td><font class="bluefnt"><%=OtherTax %></font></td>
                                                                           <td><font class="blackfnt">Educational Cess on sub-total</font></td>
  	                                                                       <td><asp:TextBox ID="otax"  Columns="8" CssClass="inputnum"  MaxLength="10" runat="server"  ReadOnly="true" ></asp:TextBox></td>
	                                                                       <td><font class="blackfnt">Educational Cess - Collected</font></td>
	                                                                       <td><asp:TextBox ID="otax_s" Columns="8" CssClass="inputnum" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" MaxLength="10" runat="server" ></asp:TextBox></td>
			                                                             </tr>
			                                                             <tr bgcolor="#FFFFFF"  id="Payment_detal_table110" runat="server">
			                                                                 <td><font class="blackfnt">Higher Educational Cess Rate (%)</font></td>
			                                                                 <td><font class="bluefnt"><%=H_OtherTax%></font></td>
			                                                                 <td><font class="blackfnt">Higher Educational Cess on sub-total</font></td>
  	                                                                         <td><asp:TextBox ID="hotax" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Columns="8" CssClass="input"  MaxLength="10" runat="server"  ReadOnly="true" ></asp:TextBox></td>
		                                                                     <td><font class="blackfnt">Higher Educational Cess - Collected</font></td>
		                                                                     <td><asp:TextBox ID="hotax_s" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Columns="8" CssClass="inputnum"  MaxLength="10" runat="server" ></asp:TextBox></td>
			                                                             </tr>
			                                                             <tr bgcolor="#FFFFFF"  id="Payment_detal_table7" runat="server">
			                                                                 <td></td>
			                                                                 <td></td>
			                                                                 <td></td>
			                                                                 <td></td>
			                                                                 <td class="blackfnt">
			                                                                    <b>TOTAL</b>
			                                                                 </td>
			                                                                 <td>
			                                                                     <asp:TextBox ID="total"  Columns="8" CssClass="input"  MaxLength="10" runat="server"  Enabled="false"></asp:TextBox>
			                                                                 </td>
			                                                                 </tr>
				                                                        </table>
				                                                        <br />
				                                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width:10in">
				                                                        <tr class="bgbluegrey" id="Payment_detal_table8" runat="server"> 
                                                                            <td colspan="6" align="center" class="blackfnt">
                                                                                <b><asp:Button ID="Submitbtn" runat="server"  Text="Submit Data"  OnClientClick="javascript:return SubmitData('<%=totdoc.ToString() %>')"  OnClick="Submitbtn_Click" /></b>
                                                                            </td>
                                                                        </tr>
				                                                    </table>
                      </ContentTemplate>
                   <Triggers>
                             <%--<asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />--%>
                             <%--<asp:AsyncPostBackTrigger ControlID="paymentdetail" EventName="Click"  />--%>
                                        <asp:AsyncPostBackTrigger ControlID="Submitbtn"   EventName="Click"  />  
                                          <asp:AsyncPostBackTrigger ControlID="chkCoddoc"   EventName="CheckedChanged"  /> 
                   </Triggers>
                 </asp:UpdatePanel>
                    </td>
        </tr>
       </table>
                 
        </div>
        <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
        <!-- #include  file="./docket_javascript.aspx" -->
       
        </asp:Content>
   
