<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Debug="true" CodeFile="docket.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_docket"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <link href="../../images/plugin.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/clickWindow.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/plugin.js"></script>

    <script language="javascript" type="text/javascript">

    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
    
    function openDockSeries(choice)
    {
        window.open(choice,'');
        return false;
    }
    
    
    
    function validateDockNo(id)
    {
        var txt=document.getElementById(id);
        txt.value=txt.value.toUpperCase();
      
        if(txt.value=="")
            return false;

        var findobj=false;
        findobj=GetXMLHttpObject();
        
    if(findobj)
    {
         var strpg="LocationTest.aspx?mode=check&code=dockno&dockno="+ txt.value + "&sid=" + Math.random();
         findobj.open("GET",strpg);
         findobj.onreadystatechange=function()
             {
                 if((findobj.readyState==4) && (findobj.status==200))
                    {
                      var  res=findobj.responseText.split("|");
                      if(res[0]=="false")
                         {
                            alert("This <%=sdkt_call %> Numer is in use or Not in series....");
                            txt.select();
                            return false;
                         }
                    }
             }
            findobj.send(null);
        }
        return true;
    }

    

    function paymentDetailClick()
    {
        var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
        var cmbloadtype=document.getElementById("ctl00_MyCPH1_cmbloadtype");
        var cmbbustype=document.getElementById("ctl00_MyCPH1_cmbbustype");
        
        
        if(hdnclient.value=="AGILITY")
        {
            if(cmbloadtype.value=="0")
            {
              
                alert("Please Select Load Type...");
                cmbloadtype.focus();
                return false;
            }
        }
        
        if(cmbbustype.value=="0")
        {
            alert("Please Select Business Type...");
            cmbbustype.focus();
            return false;
        }
        
        return true;
    }
    
   
    //  Step1 Validation
    function validateStep1()
    {
       	var txtdockdt=document.getElementById("ctl00_MyCPH1_dockdt");
        var hdnserverdate=document.getElementById("ctl00_MyCPH1_hdnserverdate");
        
        var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
        
        var arrdockdt=txtdockdt.value.split('/');
        var arrservdate=hdnserverdate.value.split('/');
        var Form_name="ctl00_MyCPH1_";
        var dockno=document.getElementById("ctl00_MyCPH1_dockno");
        
        
        
        if (dockno.value=="")
        {
	        alert("Please Enter the <%=sdkt_call %> No.");
	        dockno.select();
	        return false;
        }
    	

    	if(!validateDockNo('ctl00_MyCPH1_dockno'))
    	    return false;
    	    
    	    
    	    
    	    
    	    
    	    
    	    
        var dockdt = new Date(months[parseFloat(arrdockdt[1])] + " " + parseFloat(arrdockdt[0]) + ", " + parseFloat(arrdockdt[2]));
        var servdt = new Date(months[parseFloat(arrservdate[1])] + " " + parseFloat(arrservdate[0]) + ", " + parseFloat(arrservdate[2]));
        
        var hdnfinstartyear=document.getElementById("ctl00_MyCPH1_hdnfinstartyear");
        var finendyear = 0;
        finendyear = parseInt(hdnfinstartyear.value) + 1;
        
        var finstartdt =  new Date(months[4] + " 01, " + parseFloat(hdnfinstartyear.value));
        var finenddt =  new Date(months[3] + " 31, " + parseFloat(finendyear));
        
        var finstring = dockdt.getFullYear() + "-" + parseInt(parseInt(dockdt.getFullYear())+1);
        if(dockdt < finstartdt || dockdt>finenddt)
        {
            alert("To Enter Booking date " + txtdockdt.value + " please Change Fin Year ");
            return false;
        }
        
       
    	    
    	    
    	    
    	    
    	    
	
        
        var dockdt = new Date(months[parseFloat(arrdockdt[1])] + " " + parseFloat(arrdockdt[0]) + ", " + parseFloat(arrdockdt[2]));
        var servdt = new Date(months[parseFloat(arrservdate[1])] + " " + parseFloat(arrservdate[0]) + ", " + parseFloat(arrservdate[2]));
        
        if(dockdt>servdt)
        {
            alert("Please Enter <%=sdkt_call %> Date Less than or eqal to Today's Date...");
            txtdockdt.select();
            return false;
        }
			    
//        if(hdnclient.value=="RCPL")
//        {
//            var rcplservdt=new Date(months[parseFloat(arrservdate[1])] + " " + parseFloat(arrservdate[0]-2) + ", " + parseFloat(arrservdate[2]));
//            if(dockdt<rcplservdt)
//            {
//                alert("Please Enter <%=sdkt_call %> Date Greater than Today - 2");
//                txtdockdt.select();
//                return false;
//            }
//        }
        
      
   
        
        var cmbpaybas=document.getElementById("ctl00_MyCPH1_paybas");
        var txtpartycode=document.getElementById("ctl00_MyCPH1_consignor_Bill");
        var txtdestcode=document.getElementById("ctl00_MyCPH1_destn");
        if(cmbpaybas.value=="")
        {
             alert("Plz Select Paybas....");
             cmbpaybas.focus();
             return false;
        }
        
        if(cmbpaybas.value=="P02" || cmbpaybas.value=="P08" || cmbpaybas.value=="P09")
        {
        
            if(txtpartycode.value=="")
            {
                alert("Plz Enter Billing Party....");
                txtpartycode.focus();
                return false;
            }
        }
        
        if(txtdestcode.value=="")
        {
            alert("Plz Enter Detaination....");
            txtdestcode.focus()
            return false;
        }
        else
        {
            var ss=","+txtdestcode.value+",";
            var hdnloccodes=document.getElementById("ctl00_MyCPH1_hdnloccodes");
            if(hdnloccodes.value.indexOf(ss)<=0)
            {
                alert("Please Enter Location code Properly");
                txtdestcode.select();
                txtdestcode.focus();
                return false;
            }
        }
        
        
        
              
        return true;
    }
    
    
    
    
    
    function chkCODClick()
    {
        var div=documet.getElementById("ctl00_MyCPH1_divcod");
        var chk=documet.getElementById("ctl00_MyCPH1_chkcoddoc");
        if(chk.checked==true)
            div.style.display="block";
         else
            div.style.display="none";
            
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
        {event.keyCode=0;return false;}
}

    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
 
    <div id="glideDiv" style="right: -104px; top: 28px">
    </div>
    <div>
        <table style="width:10in;" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <font class="blackfnt"><a href="../../welcome.aspx"><font class="blklnkund"><strong>
                        Module</strong></font></a><strong> &gt; </strong></font><a href="#"><font class="blklnkund">
                            <strong>Operation</strong></font> </a>&gt; <font class="bluefnt"><strong>
                                <%=sdkt_call %>
                                Entry </strong></font>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <asp:HiddenField ID="DocketMode" runat="server" />
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td>
                                            <p>
                                                <font class="blackfnt"><b><u>Note ::></u></b> Fields marked with <font class="blackfnt"
                                                    color="red"><b>'*'</b></font> are compulsory.</font></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel ID="paydetal_error" runat="server">
                                                <ContentTemplate>
                                                    <asp:Label ID="Payment_detal_errmsg1" Text="" runat="server" CssClass="blackfnt"
                                                        ForeColor="red"></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                             THIS TABLE GETS LOCATION AND BILLING PARTY INFOR                    
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=--%>
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in">
                                            <tr>
                                                <td colspan="6" align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>
                                                        <%=sdkt_call %>
                                                        Detail </b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td style="height: 24px">
                                                    <font class="blackfnt"><font class="redfnt">*</font><asp:Label ID="lbldocklabel"
                                                        runat="server"></asp:Label>
                                                    </font>
                                                </td>
                                                <td style="height: 24px">
                                                        <asp:TextBox ID="dockno" TabIndex="1" onblur="javascript:return validateDockNo(this.getAttribute('id'))" MaxLength="10"
                                                             class="input" runat="server"></asp:TextBox><a onclick="javascript:return openDockSeries('Available_dockets.aspx')" onmouseover="this.style.cursor='pointer'" >
                                                             <asp:Image ID="imgdocknoque" runat="server" ImageUrl="~/GUI/images/question.GIF" /></a>
                                                             <asp:HiddenField ID="validation_chk" runat="server" />
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="redfnt">*</font><font class="blackfnt"><%=sdkt_call %>
                                                        Date </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <asp:TextBox ID="dockdt" TabIndex="1" CssClass="input" runat="server" Width="55"
                                                        MaxLength="10"> </asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_dockdt,'anchor1','dd/MM/yyyy'); return false;"
                                                        name="anchor1" id="anchor1">
                                                        <img alt="" src="../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="blackfnt"><font class="redfnt">*</font>Payment Type </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>
                                                            <asp:DropDownList ID="paybas" OnTextChanged="onBlur_party" AutoPostBack="true" onchange="javascript:return partyEnable()"
                                                                runat="server">
                                                            </asp:DropDownList>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="paybas" EventName="TextChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td style="height: 24px">
                                                    <font class="blackfnt">Billing Party </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <asp:UpdatePanel ID="Partydetail" runat="server">
                                                        <ContentTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="consignor_Bill" OnTextChanged="onBlur_party" AutoPostBack="true"
                                                                            onchange="javascript:this.value=this.value.toUpperCase()" onFocus="javascript:this.value=this.value.replace('H_','')"
                                                                            Enabled="false" runat="server" Columns="8">
                                                                        </asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="consignor_Bill_name" Enabled="false" runat="server" Columns="15"></asp:TextBox>&nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnPopUp" Text="...." runat="server" OnClick="Row_Invisible" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="lblcontract_check" Text="" runat="server" CssClass="blackfnt" ForeColor="red"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="consignor_Bill" EventName="TextChanged" />
                                                            <asp:AsyncPostBackTrigger ControlID="btnPopUp" EventName="Click" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="blackfnt">Origin </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="bluefnt">
                                                        <%=Session["Brcd"].ToString() %>
                                                        <asp:HiddenField ID="Orgn" runat="server" />
                                                    </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="blackfnt"><font class="redfnt">*</font>Delivery Control Location </font>
                                                </td>
                                                <td style="height: 24px">
                                                            <asp:TextBox ID="destn" CssClass="input" onblur="javascript:return destCodeTest(this.getAttribute('id'))"
                                                                runat="server" Columns="2" MaxLength="8"></asp:TextBox>
                                                            <input id="btnPopupLoc" type="button" value="..." name="custpup12" runat="server" />
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF" id="DOCKET_DETAIL_ROW3" runat="server">
                                                <td style="height: 24px">
                                                    <font class="blackfnt"><font class="redfnt">*</font>Pickup/Delivery </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <asp:DropDownList ID="cboPickupDely" runat="server">
                                                     <asp:ListItem Value='1'>Godown Pickup - Godown Delivery </asp:ListItem>
                                                        <asp:ListItem Value='2'>Godown Pickup - Door Delivery</asp:ListItem>
                                                        <asp:ListItem Value='3'>Door Pickup - Door Delivery</asp:ListItem>
                                                        <asp:ListItem Value='4'>Door Pickup - Godown Delivery</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="blackfnt">From </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <asp:UpdatePanel ID="Fromlocation" runat="server">
                                                        <ContentTemplate>
                                                            <asp:TextBox ID="destfrom" runat="server" Columns="12"></asp:TextBox>
                                                            <input id="btnFrom" type="button" value="..." name="custpup12" runat="server" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td style="height: 24px">
                                                    <font class="blackfnt">To </font>
                                                </td>
                                                <td style="height: 24px">
                                                    <asp:UpdatePanel ID="Tolocation" runat="server">
                                                        <ContentTemplate>
                                                            <asp:TextBox ID="destto" runat="server" Columns="12"></asp:TextBox>
                                                            <input id="btnTo" type="button" value="..." name="custpup12" runat="server" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF" id="DOCKET_DETAIL_ROW4" runat="server">
                                                <td>
                                                    <font class="blackfnt">Volumetric</font></td>
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                                        <ContentTemplate>
                                                            <asp:CheckBox ID="chkcft" runat="server" OnCheckedChanged="NOOFROWS" AutoPostBack="true" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td>
                                                    <font class="blackfnt">COD/DOD</font></td>
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePa010" runat="server">
                                                        <ContentTemplate>
                                                            <asp:CheckBox ID="chkCoddoc" runat="server" AutoPostBack="true" OnCheckedChanged="fOnChangepaybas_for_otherControl" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td>
                                                    <font class="blackfnt">ODA</font></td>
                                                <td>
                                                    <asp:UpdatePanel ID="UpdatePanel13" runat="server">
                                                        <ContentTemplate>
                                                            <asp:CheckBox ID="chkoda" runat="server" Enabled="false" AutoPostBack="true" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                             <tr bgcolor="#FFFFFF" id="trdacc" runat="server">
                                                <td>
                                                    <font class="blackfnt">DACC</font></td>
                                                <td>
                                                 <asp:UpdatePanel ID="UpdatePanel14" runat="server">
                                                        <ContentTemplate>
                                                                <asp:CheckBox ID="chkdacc" AutoPostBack="true" OnCheckedChanged="fOnChangepaybas" runat="server" />
                                                      </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF" id="DOCKET_DETAIL_ROW5" runat="server">
                                                <td>
                                                    <font class="blackfnt">Local <%=sdkt_call %></font></td>
                                                <td>
                                                    <asp:CheckBox ID="local_yn" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblloadcaption" CssClass="blackfnt" runat="server">Load Type</asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="cmbloadtype" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    Business Type
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="cmbbustype" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <asp:UpdatePanel ID="state_documentdetail" runat="server">
                                                <ContentTemplate>
                                                    <tr bgcolor="#FFFFFF" runat="server" align="right">
                                                        <td colspan="6">
                                                            <asp:Button ID="Btn_enable" Text="Enable Billing Party & Destination" CssClass="blackfnt"
                                                                runat="server" OnClick="EnableParty_Dest" />
                                                            <asp:Button ID="btnstep1" Text="Step 1" CssClass="blackfnt" OnClientClick="javascript:return validateStep1()" runat="server" OnClick="btnstep1_Click" />
                                                        </td>
                                                    </tr>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="btnstep1" EventName="Click" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <br />
                                <br />
                                <%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                             THIS TABLE GETS CONSIGNOR AND COSIGNEE DETAILS                    
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>
                                <asp:UpdatePanel ID="Cnor_Cnee_UpdatePanel" runat="server">
                                    <ContentTemplate>
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in" id="Cnor_Cnee_detail"
                                            runat="server">
                                            <tr class="bgbluegrey">
                                                <td class="bgbluegrey">
                                                </td>
                                                <td align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>Consignor</b></font></td>
                                                <td align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>Consignee</b></font></td>
                                                <td colspan="3" align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>Document</b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td style="height: 53px" class="blackfnt">
                                                    Code</td>
                                                <td align="left" class="blackfnt" style="height: 53px;">
                                                    <font class="redfnt"><b>*</b></font>Enter from existing Consignor<br />
                                                        <asp:TextBox TabIndex="1" ID="consignor_name_B" CssClass="input" runat="server" Columns="8"></asp:TextBox>
                                                        <asp:TextBox TabIndex="1" CssClass="input" ID="consignor_name_B_nm" runat="server" Columns="15"></asp:TextBox>
                                                        <input tabindex="1" type="button" class="blackfnt" id="btn1" value="..." runat="server" />
                                                </td>
                                                <td align="left" class="blackfnt" style="height: 53px;">
                                                    <font class="redfnt"><b>*</b></font>Enter from existing Consignee<br />
                                                            <asp:TextBox ID="consignee_name_B" TabIndex="2" class="input" runat="server" Columns="10"></asp:TextBox>
                                                            <asp:TextBox class="input" TabIndex="2" ID="consignee_name_B_nm" runat="server" Columns="15"></asp:TextBox>
                                                            <input tabindex="2" class="blackfnt" type="button" id="Btn2" value="..." runat="server" />
                                                </td>
                                                <td align="left" style="height: 53px;">
                                                    <font class="blackfnt">Risk Type </font>
                                                </td>
                                                <td colspan="2" align="left" style="height: 53px">
                                                    <asp:RadioButtonList ID="ins" TabIndex="3" CssClass="blackfnt" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="C" Selected="True">Carrier's Risk</asp:ListItem>
                                                        <asp:ListItem Value="O">Owner's Risk</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td colspan="3" align="center">
                                                    <font class="blackfnt"><b>New </b>&nbsp;</font>
                                                </td>
                                                <td align="left" class="blackfnt">
                                                    Policy No &amp; Date</td>
                                                <td align="left" colspan="2">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:TextBox ID="policyno" TabIndex="3" runat="server" Columns="10"></asp:TextBox>
                                                                <asp:TextBox ID="txtinsdt" TabIndex="3" runat="server" Columns="10"></asp:TextBox>
                                                                <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtinsdt,'anchor11','dd/MM/yyyy'); return false;"
                                                                    name="anchor11" id="anchor11">
                                                                    <img alt="" src="../../images/calendar.jpg" border="0" />
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td align="left">
                                                    <font class="blackfnt"><b><font class="redfnt">*</font>Name </b>&nbsp;</font>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox TabIndex="1" ID="consignor_name" CssClass="input" runat="server" Columns="30"></asp:TextBox></td>
                                                <td align="left">
                                                    <asp:TextBox ID="consignee_name" TabIndex="2" CssClass="input" runat="server" Columns="30"></asp:TextBox></td>
                                                <td align="left">
                                                    <font class="blackfnt">Internal covers </font>
                                                </td>
                                                <td align="left" colspan="2">
                                                    <table>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:CheckBox ID="chk1" TabIndex="3" runat="server" />
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
                                                    <asp:TextBox ID="consignor_add" TabIndex="1" CssClass="input" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                                                <td align="left">
                                                    <asp:TextBox ID="consignee_add" TabIndex="2" CssClass="input" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                                                <td class="blackfnt" align="left">
                                                    Modvat covers
                                                </td>
                                                <td align="left" colspan="2">
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:CheckBox ID="modvat" TabIndex="3" runat="server" />
                                                                <asp:TextBox ID="totmodvat" runat="server" TabIndex="3" Columns="10"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td align="left">
                                                    <font class="blackfnt"><font class="redfnt">*</font>City - Pincode</font></td>
                                                <td align="left">
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="consignor_city" TabIndex="1" CssClass="input" runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>-<asp:TextBox
                                                                    ID="consignor_pin" TabIndex="1" onkeypress="javascript:return validInt(event)"
                                                                    CssClass="input" MaxLength="6" runat="server" Columns="5"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td align="left">
                                                        <table style="width: 100%;">
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="consignee_city" TabIndex="2" CssClass="input" runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>-
                                                                    <asp:TextBox ID="consignee_pin" TabIndex="2" onkeypress="javascript:return validInt(event)"
                                                                        CssClass="input" MaxLength="6" runat="server" Columns="5"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                </td>
                                                <td align="left">
                                                    <font class="blackfnt">Customer ref.</font></td>
                                                <td align="left">
                                                    <asp:TextBox ID="ctrno" TabIndex="3" MaxLength="10" runat="server" Columns="15"></asp:TextBox></td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td align="left">
                                                    <font class="blackfnt"><font class="redfnt">*</font>Telephone</font></td>
                                                <td style="height: 26px;">
                                                    <asp:TextBox ID="consignor_telno" onkeypress="javascript:return validInt(event)"
                                                        CssClass="input" TabIndex="1" runat="server"></asp:TextBox></td>
                                                <td align="left" style="height: 26px;">
                                                    <asp:TextBox ID="consignee_telno" onkeypress="javascript:return validInt(event)"
                                                        CssClass="input" TabIndex="2" runat="server"></asp:TextBox></td>
                                                <td align="left" style="height: 26px;">
                                                    <font class="blackfnt">Private mark</font></td>
                                                <td colspan="2" align="left" style="height: 26px">
                                                    <asp:TextBox ID="txtprivatemark" TabIndex="3" MaxLength="10" runat="server" Columns="15"></asp:TextBox></td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td align="left" style="height: 26px">
                                                    <font class="blackfnt">Email</font></td>
                                                <td align="left" style="height: 26px;">
                                                    <asp:TextBox ID="consignor_email" TabIndex="1" runat="server" Columns="30"></asp:TextBox></td>
                                                <td style="height: 26px;">
                                                    <asp:TextBox ID="consignee_email" TabIndex="2" runat="server" Columns="30"></asp:TextBox></td>
                                                <td align="left" style="height: 26px;">
                                                    <font class="blackfnt">TP Number</font></td>
                                                <td align="left" style="height: 26px" colspan="2">
                                                    <asp:TextBox ID="txttpno" TabIndex="3" MaxLength="10" runat="server" Columns="15"></asp:TextBox></td>
                                            </tr>
                                            <tr id="trodbno" runat="server" bgcolor="#ffffff" class="blackfnt">
                                                <td align="left" style="height: 26px">OBD No.</td>
                                                <td align="left" style="height: 26px;">
                                                    <asp:TextBox ID="txtobdno" runat="server" onblur="this.value=this.value.toUpperCase()" MaxLength="30"></asp:TextBox>
                                                </td>
                                                <td align="left" style="height: 26px;"></td>
                                                <td style="height: 26px;">Entry Sheet No</td>
                                                <td align="left" style="height: 26px;" colspan="2">
                                                    <asp:TextBox ID="txtentrysheetno" onblur="this.value=this.value.toUpperCase()" runat="server" MaxLength="30"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <p>
                                </p>
                                <asp:UpdatePanel ID="state_docdetail" runat="server">
                                    <ContentTemplate>
                                        <%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS GRID GETS DOCUMENT DETAILS                   
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in" id="Documents_detail"
                                            runat="server">
                                            <tr id="state_doc_table" runat="server" visible="false">
                                                <td colspan="4" align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>Document Details </b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td colspan="4">
                                                    <asp:GridView ID="rptDocketList" align="center" runat="server" AutoGenerateColumns="False"
                                                        Width="100%" Style="text-align: left" CssClass="blackfnt" Visible="true" DataKeyField="dockno">
                                                        <AlternatingRowStyle BackColor="#EEEEEE" CssClass="blackfnt" />
                                                        <HeaderStyle CssClass="bgbluegrey" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Document Name" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:Label CssClass="blackfnt" ID="STFORM" Text='<%# DataBinder.Eval(Container.DataItem,"STFORM") %>'
                                                                            runat="server"></asp:Label>
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:Label CssClass="blackfnt" ID="STCSTREQ" Text='<%# DataBinder.Eval(Container.DataItem,"STCSTREQ") %>'
                                                                            runat="server"></asp:Label>
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"
                                                                HeaderStyle-HorizontalAlign="Center">
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:Label CssClass="blackfnt" ID="STNM" Text='<%# DataBinder.Eval(Container.DataItem,"STNM") %>'
                                                                            runat="server"></asp:Label>
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="Declared_Value1" CssClass="blackfnt" Text="Enclosed Document Number"
                                                                        runat="server"></asp:Label></HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:TextBox ID="docu" runat="server" MaxLength="20" Columns="12" CssClass="input"
                                                                            onchange="javascript:this.value=this.value.toUpperCase()" Text=""></asp:TextBox>
                                                                        <asp:HiddenField ID="Doc_srno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Doc_srno") %>' />
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="destn" EventName="TextChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                                <p>
                                </p>
                                <%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS TABLE SHOWS PERMIT TRACKER                
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>
                                <asp:UpdatePanel ID="Permit_tracker_UpdatePanel" runat="server">
                                    <ContentTemplate>
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in" id="Permit_tracker_detail"
                                            runat="server">
                                            <tr>
                                                <td colspan="6" align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>Permit Tracker </b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td>
                                                    <font class="blackfnt">Permit Applicable</font></td>
                                                <td>
                                                    <input id="txtpermit_yn" class="input" name="txtpermit_yn" type="hidden" size="9"
                                                        value="No" onfocus="this.blur()" runat="server" /><asp:CheckBox ID="permit_yn" runat="server"
                                                            Columns="15" /></td>
                                                <td>
                                                    <font class="blackfnt">Permit Received At</font></td>
                                                <td>
                                                    <asp:DropDownList ID="permit_recvd_at" runat="server">
                                                        <asp:ListItem Value="">Select</asp:ListItem>
                                                        <asp:ListItem Value="B">Booking</asp:ListItem>
                                                        <asp:ListItem Value="D">Delivery</asp:ListItem>
                                                        <asp:ListItem Value="C">Check Post</asp:ListItem>
                                                    </asp:DropDownList></td>
                                                <td>
                                                    <font class="blackfnt">Permit No.</font></td>
                                                <td>
                                                    <asp:TextBox ID="permitno" runat="server" Columns="15"></asp:TextBox></td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td>
                                                    <font class="blackfnt">Permit Date</font></td>
                                                <td>
                                                    <asp:TextBox ID="permitdt" runat="server" Columns="15"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_permitdt,'anchor12','dd/MM/yyyy'); return false;"
                                                        name="anchor12" id="anchor12">
                                                        <img alt="" src="../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </td>
                                                <td>
                                                    <font class="blackfnt">Permit Validity Date</font></td>
                                                <td>
                                                    <asp:TextBox ID="permit_val_dt" runat="server" Columns="15"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_permit_val_dt,'anchor13','dd/MM/yyyy'); return false;"
                                                        name="anchor13" id="anchor13">
                                                        <img alt="" src="../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </td>
                                                <td>
                                                    <font class="blackfnt">Permit Received Date</font></td>
                                                <td>
                                                    <asp:TextBox ID="permit_recvd_dt" runat="server" Columns="15"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_permit_recvd_dt,'anchor14','dd/MM/yyyy'); return false;"
                                                        name="anchor14" id="anchor14">
                                                        <img alt="" src="../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <p>
                                </p>
                                <%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS TABLE SHOWS PERMIT TRACKER                
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>
                                <asp:UpdatePanel ID="Invoice_detail_UpdatePanel" runat="server">
                                    <ContentTemplate>
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in" id="Invoice_detail"
                                            runat="server">
                                            <tr>
                                                <td colspan="9" align="center" class="bgbluegrey">
                                                    <input id="cltotdoc" name="cltotdoc" type="hidden" runat="server" />
                                                    <font class="blackfnt"><b>Invoice Details </b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td colspan="2" align="right" class="blackfnt">
                                                    <b>Enter No Of Rows</b>
                                                </td>
                                                <td colspan="7" align="left">
                                                    <font class="blackfnt"><b>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                <asp:TextBox ID="noofrows1" TabIndex="1" onblur="rowBlur(this.getAttribute('id'))"
                                                                    OnTextChanged="NOOFROWS" onkeypress="javascript:validInt(event)" Columns="5"
                                                                    AutoPostBack="true" runat="server"> </asp:TextBox>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td colspan="9">
                                                    <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                                        <ContentTemplate>
                                                            <table cellspacing="1" class="boxbg" style="width: 100%" id="cft_detal_row" runat="server"
                                                                visible="false">
                                                                <tr bgcolor="#ffffff">
                                                                    <td class="blackfnt">
                                                                        <font class="redfnt" color="red"><b>* </b></font>Cubic ft. Conversion ratio
                                                                    </td>
                                                                    <td>
                                                                        <font class="bluefnt">1 Cubic ft. =
                                                                            <asp:TextBox runat="server" ID="cftratio" Columns="5" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                                                MaxLength="5"></asp:TextBox>
                                                                            Kg.</font></td>
                                                                    <td>
                                                                        <font class="blackfnt"><font class="black" color="red"><b>* </b></font>Total Cubic ft.</font></td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" Style="" ID="total_cft" Columns="5" onkeypress="validFloat(event,this.getAttribute('id'))"
                                                                            MaxLength="5"></asp:TextBox></td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#FFFFFF">
                                                <td colspan="9">
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="invdata" align="center" runat="server" AutoGenerateColumns="False"
                                                                Width="100%" Style="text-align: left" CssClass="blackfnt" OnRowDataBound="invdata_RowDataBound"
                                                                Visible="true" DataKeyField="dockno">
                                                                <AlternatingRowStyle BackColor="#EEEEEE" CssClass="blackfnt" />
                                                                <HeaderStyle CssClass="bgbluegrey" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="SRNO" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:Label CssClass="blackfnt" ID="SRNO" Text='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>'
                                                                                    runat="server">
                                                                                </asp:Label>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblinvstarno" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                                                            <asp:Label ID="InvoiceNo" CssClass="blackfnt" Text="Invoice No." runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="invno" runat="server" TabIndex="1" MaxLength="20" Columns="10" CssClass="input"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblinvstardate" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                                                            <asp:Label ID="Invoice_Date" TabIndex="1" CssClass="blackfnt" Text="Invoice Date"
                                                                                runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="invdt" TabIndex="1" runat="server" MaxLength="10" Columns="10" CssClass="input"></asp:TextBox>
                                                                                <asp:LinkButton ID="lnkdate" runat="server">
                                                                                            <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                                                                </asp:LinkButton>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblinvstardelval" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                                                            <asp:Label ID="Declared_Value" CssClass="blackfnt" onkeypress="javascript:validInt(event)"
                                                                                Text="Declared Value" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="declvalue" TabIndex="1" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                                    MaxLength="10" Columns="8" CssClass="input" Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblinvstarpkgsno" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                                                            <asp:Label ID="No_of_Pkgs" CssClass="blackfnt"
                                                                                Text="No. of Pkgs." runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="pkgno" TabIndex="1" runat="server" onkeypress="javascript:validInt(event)" MaxLength="10" Columns="8" Text="0"
                                                                                    CssClass="input"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" AccessibleHeaderText="actwt_test"
                                                                        Visible="true">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="lblinvstaractwt" runat="server" CssClass="redfnt" Font-Bold="true">*</asp:Label>
                                                                            <asp:Label ID="Actual_Weight" TabIndex="1" CssClass="blackfnt" 
                                                                                Text="Actual Weight" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="actwt" TabIndex="1" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" MaxLength="10" Columns="8" Text="0"
                                                                                    CssClass="input"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:GridView ID="invdata_cft" align="center" runat="server" AutoGenerateColumns="False"
                                                                Width="100%" Style="text-align: left" CssClass="blackfnt" OnRowDataBound="invdata_cft_RowDataBound"
                                                                Visible="true" DataKeyField="dockno">
                                                                <AlternatingRowStyle BackColor="#EEEEEE" CssClass="blackfnt" />
                                                                <HeaderStyle CssClass="bgbluegrey" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="SRNO" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:Label CssClass="blackfnt" ID="SRNO" Text='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>'
                                                                                    runat="server">
                                                                                </asp:Label>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="InvoiceNo" CssClass="blackfnt" Text="Invoice No." runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <font class="redfnt">*</font>
                                                                                <asp:TextBox ID="invno" runat="server" MaxLength="20" Columns="12" CssClass="input"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <font class="redfnt">*</font>
                                                                            <asp:Label ID="Invoice_Date" CssClass="blackfnt" Text="Invoice Date" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="invdt" runat="server" MaxLength="10" Columns="10" CssClass="input"></asp:TextBox>
                                                                                <asp:LinkButton ID="lnkdate" runat="server">
                                                                                                    <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                                                                </asp:LinkButton>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <font class="redfnt">*</font>
                                                                            <asp:Label ID="Declared_Value" CssClass="blackfnt" Text="Declared Value" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="declvalue" CssClass="inputnum" runat="server" MaxLength="8" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Columns="8"
                                                                                    Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <font class="redfnt">*</font>
                                                                            <asp:Label ID="No_of_Pkgs" CssClass="blackfnt" Text="No. of Pkgs." runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="pkgno" CssClass="inputnum" onkeypress="javascript:validInt(event)" runat="server" MaxLength="8" Columns="8"
                                                                                    Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="Length1" CssClass="blackfnt" Text="Length" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="length" CssClass="inputnum" runat="server" MaxLength="5" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Columns="5"
                                                                                    Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="Breadth1" CssClass="blackfnt" Text="Breadth" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="breadth" CssClass="inputnum" runat="server" MaxLength="5" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Columns="5"
                                                                                    Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="height1" CssClass="blackfnt" Text="height" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="height" runat="server" CssClass="inputnum" MaxLength="5" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Columns="5"
                                                                                    Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="cubicfit" CssClass="blackfnt" Text="Total" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="cftval" CssClass="inputnum" runat="server" MaxLength="5" Columns="5"
                                                                                    ReadOnly="true" Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" AccessibleHeaderText="actwt_test"
                                                                        Visible="true">
                                                                        <HeaderTemplate>
                                                                            <asp:Label ID="Actual_Weight" CssClass="blackfnt" Text="Actual Weight" runat="server"></asp:Label>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <asp:TextBox ID="actwt" CssClass="inputnum" runat="server" MaxLength="8" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Columns="8"
                                                                                    Text="0"></asp:TextBox>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="noofrows1" EventName="TextChanged" />
                                                            <asp:AsyncPostBackTrigger ControlID="chkcft" EventName="CheckedChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <p>
                                </p>
                                <asp:UpdatePanel ID="updt_service" runat="server">
                                    <ContentTemplate>
                                        <%--*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                        THIS TABLE SHOWS CONSIGNMENT DETAILS             
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*--%>
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in" id="Consignment_detail"
                                            runat="server">
                                            <tr>
                                                <td colspan="6" align="center" class="bgbluegrey">
                                                    <font class="blackfnt"><b>Consignment Details </b></font>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td class="blackfnt" style="height: 26px; width: 180px;">
                                                    Total Declare Value</td>
                                                <td style="height: 26px; width: 116px;">
                                                    <asp:TextBox ID="decl" Enabled="false" class="input" runat="server" Columns="5"></asp:TextBox>
                                                </td>
                                                <td style="height: 26px; width: 191px;">
                                                    &nbsp;
                                                </td>
                                                <td style="height: 26px" colspan="3">
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td style="height: 26px; width: 180px;">
                                                    <font class="blackfnt">Total No. of packages</font></td>
                                                <td style="height: 26px; width: 116px;">
                                                    <asp:TextBox ID="pkg" Enabled="false" class="input" runat="server" Columns="5"></asp:TextBox>
                                                </td>
                                                <td style="height: 26px; width: 191px;">
                                                    <font class="blackfnt"><font class="redfnt">*</font> Packaging Type</font></td>
                                                <td style="height: 26px" colspan="3">
                                                    <asp:DropDownList ID="pkgtyp" runat="server">
                                                        <asp:ListItem>Select</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td style="width: 180px" class="blackfnt">
                                                    Total Actual weight (Kg.)</td>
                                                <td style="width: 116px">
                                                    <asp:TextBox ID="awt" Enabled="false" class="input" runat="server" Columns="5"></asp:TextBox>
                                                </td>
                                                <td class="blackfnt" style="width: 191px">
                                                    Said to contain (Product)</td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="prod" runat="server">
                                                        <asp:ListItem>Select</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff" class="blackfnt">
                                                <td style="width: 180px">
                                                    <font class="redfnt">*</font>Charged weight (Kg.)
                                                </td>
                                                <td style="width: 116px">
                                                    <asp:TextBox ID="cwt" class="input" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                        onblur="javascript:return Onchange_chrgwt()" runat="server" Columns="5"></asp:TextBox></td>
                                                <td style="width: 191px">
                                                    <font class="blackfnt">Special Instructions</font></td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="spl_inst" runat="server" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr bgcolor="#ffffff">
                                                <td style="width: 180px">
                                                    <font class="blackfnt"><font class="redfnt">*</font> Mode</font></td>
                                                <td style="width: 116px">
                                                    <asp:DropDownList ID="trans" runat="server" Width="65px" AutoPostBack="true" OnSelectedIndexChanged="fOnChangepaybas_for_otherControl">
                                                        <asp:ListItem>Select</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 191px">
                                                    <font class="blackfnt"><font class="redfnt">*</font> Service Type</font></td>
                                                <td>
                                                    <asp:DropDownList ID="service" onchange="javascript:return enableBox()" runat="server"
                                                        AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="fOnChangepaybas_for_otherControl">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <font class="blackfnt"><font class="redfnt">*</font> Type of FTL</font></td>
                                                <td>
                                                    <asp:DropDownList ID="service_ftl" runat="server" AutoPostBack="true" OnSelectedIndexChanged="fOnChangepaybas_for_otherControl">
                                                        <asp:ListItem>Select</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                    <center>
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </center>
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <center>
                                <p>
                                    <asp:Label ID="Payment_detal_errmsg" Text="" runat="server" CssClass="blackfnt" ForeColor="red"></asp:Label>
                                    <asp:Button Text="Click here for Payment Detail" runat="server" OnClientClick="javascript:return paymentDetailClick()" ID="paymentdetail"
                                        Visible="false" OnClick="fOnChangepaybas" /></p>
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
                                        <asp:HiddenField ID="CHG_SCHG01" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG02" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG03" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG04" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG05" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG06" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG07" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG08" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG09" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG10" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG11" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG12" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG13" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG14" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG15" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG16" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG17" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG18" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG19" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG20" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG21" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG22" runat="server" />
                                        <asp:HiddenField ID="CHG_SCHG23" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG01" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG02" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG03" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG04" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG05" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG06" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG07" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG08" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG09" runat="server" />
                                        <asp:HiddenField ID="CHG_UCHG10" runat="server" />
                                        <asp:HiddenField ID="CHG_FOV" runat="server" />
                                        
                                        <asp:HiddenField ID="hdnservice" runat="server" />
                                        <asp:HiddenField ID="hdnloccodes" runat="server" />
                                        
                                        <asp:HiddenField ID="Payment_detail_show" runat="server" Value="N" />
                                        <asp:HiddenField ID="min_pkgsno" runat="server" Value="0" />
                                        <asp:HiddenField ID="min_frt" runat="server" Value="0" />
                                        <asp:HiddenField ID="min_chrgwt" runat="server" Value="0" />
                                        <asp:HiddenField ID="trms_Rate_Kg" runat="server" Value="0" />
                                        <asp:HiddenField ID="trms_Rate_Pkg" runat="server" Value="0" />
                                        
                                        <asp:HiddenField ID="hdnfreight" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnfreightrate" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnstaxrate" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnedurate" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnhedurate" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdncftratio" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnserverdate" runat="server" />
                                        <asp:HiddenField ID="hdnfinstartyear" runat="server" />
                                        <asp:HiddenField ID="hdnclient" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in">
                                <%--#include file="./add_contract_charges.asp"--%>
                                <%--Dynamically populate charges table in code behind--%>
                                <tr id="Payment_detal_table1" runat="server" visible="false">
                                    <td colspan="6" align="center" class="bgbluegrey">
                                        <font class="blackfnt"><b>Payment Details </b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table2" runat="server" visible="false">
                                    <td>
                                        <font class="blackfnt">Service Tax Paid By</font></td>
                                    <td>
                                        <asp:DropDownList ID="staxpaidby" runat="server" Width="65px">
                                            <asp:ListItem Value="">Select</asp:ListItem>
                                            <asp:ListItem Value="Billing party">Billing party</asp:ListItem>
                                            <asp:ListItem Value="Consignor">Consignor</asp:ListItem>
                                            <asp:ListItem Value="Consignee">Consignee</asp:ListItem>
                                            <asp:ListItem Value="Transporter">Transporter</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Service Tax Reg. No.</font></td>
                                    <td>
                                        <asp:TextBox ID="staxregno" Columns="10" MaxLength="10" runat="server"></asp:TextBox></td>
                                    <td>
                                        <font class="blackfnt">Billed At</font></td>
                                    <td>
                                        <asp:TextBox ID="fincmplbr" Columns="2" CssClass="input" MaxLength="5" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table3" runat="server" visible="false">
                                    <td class="blackfnt">
                                        Freight charges</td>
                                    <td>
                                        <asp:TextBox ID="frieght" Columns="8" CssClass="input" style="text-align:right;" MaxLength="10" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ratetype" runat="server" Width="65px">
                                            <asp:ListItem Value='W'>Rate/Kg</asp:ListItem>
                                            <asp:ListItem Value='P'>Rate/Pkg</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="rate" Columns="8" CssClass="input" style="text-align:right;" MaxLength="10" runat="server"></asp:TextBox>
                                    </td>
                                    <td class="blackfnt">
                                        EDD</td>
                                    <td>
                                        <asp:TextBox ID="txtDelyDt" runat="server" Columns="8" CssClass="input"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDelyDt,'anchor2','dd/MM/yyyy'); return false;"
                                            name="anchor2" id="anchor2">
                                            <img src="../../images/calendar.jpg" border="0">
                                        </a>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table9" runat="server" visible="true">
                                    <td colspan="6">
                                        <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in">
                                            <%=blnAppForFOVCharges %>
                                            <tr bgcolor="#ffffff">
                                                <td class="blackfnt" align="left" colspan="2">
                                                    COD/DOD Charges</td>
                                                <td class="blackfnt" align="left"> 
                                                     <asp:TextBox ID="txtcodchrg" CssClass="input" Text="0.00" Columns="10" onblur="javascript:FreightCalc()"
                                                        style="text-align:right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" runat="server"></asp:TextBox>
                                                </td>
                                                <td class="blackfnt" align="left" colspan="2">
                                                    COD/DOD Amount To Be Collected</td>
                                                <td class="blackfnt" align="left"> 
                                                    <asp:TextBox ID="txtcodamt" CssClass="input" style="text-align:right;" Text="0.00" Columns="10" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                        runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <%=strContractCharges %>
                                            <%=strContractChargesHidden %>
                                        </table>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table4" runat="server" visible="false">
                                    <td></td><td></td><td></td><td></td>
                                    <td>
                                        <font class="blackfnt"><b>SUB-TOTAL</b></font></td>
                                    <td>
                                        <asp:TextBox ID="subtotal" Columns="8" CssClass="input" MaxLength="10" runat="server"
                                           style="text-align:right;"  Enabled="false"></asp:TextBox></td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table5" runat="server" visible="false">
                                    <td>
                                        <font class="blackfnt">Service Tax Rate %</font></td>
                                    <td>
                                        <font class="bluefnt">
                                            <%=ServiceTax %>
                                        </font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Service tax on sub-total</font></td>
                                    <td>
                                        <asp:TextBox ID="stax" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            style="text-align:right;" Enabled="false" Columns="8" CssClass="input" MaxLength="10" runat="server" ReadOnly="true"></asp:TextBox></td>
                                    <td>
                                        <font class="blackfnt">Service tax- Collected</font></td>
                                    <td>
                                        <asp:TextBox ID="stax_s"  onblur="javascript:Edit_svc_detail()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                           style="text-align:right;"   Columns="8" CssClass="input" MaxLength="10" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table6" runat="server" visible="false">
                                    <td>
                                        <font class="blackfnt">Educational Cess Rate (%)</font></td>
                                    <td>
                                        <font class="bluefnt">
                                            <%=OtherTax %>
                                        </font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Educational Cess on sub-total</font></td>
                                    <td>
                                        <asp:TextBox ID="otax" Columns="8" CssClass="input" MaxLength="10" runat="server"
                                            style="text-align:right;" ReadOnly="true"></asp:TextBox></td>
                                    <td>
                                        <font class="blackfnt">Educational Cess - Collected</font></td>
                                    <td>
                                        <asp:TextBox ID="otax_s" Columns="8"   onblur="javascript:Edit_svc_detail()"  CssClass="input" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            style="text-align:right;" MaxLength="10" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table110" runat="server" visible="false">
                                    <td>
                                        <font class="blackfnt">Higher Educational Cess Rate (%)</font></td>
                                    <td>
                                        <font class="bluefnt">
                                            <%=H_OtherTax%>
                                        </font>
                                    </td>
                                    <td>
                                        <font class="blackfnt">Higher Educational Cess on sub-total</font></td>
                                    <td>
                                        <asp:TextBox ID="hotax" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            style="text-align:right;" Columns="8" CssClass="input" MaxLength="10" runat="server" ReadOnly="true"></asp:TextBox></td>
                                    <td>
                                        <font class="blackfnt">Higher Educational Cess - Collected</font></td>
                                    <td>
                                        <asp:TextBox ID="hotax_s"  onblur="javascript:Edit_svc_detail()"  onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            style="text-align:right;" Columns="8" CssClass="input" MaxLength="10" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table7" runat="server" visible="false">
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <font class="blackfnt"><b>TOTAL</b></font></td>
                                    <td>
                                        <asp:TextBox ID="total" Columns="8" CssClass="input" style="text-align:right;" MaxLength="10" runat="server"
                                            Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table cellpadding="3" cellspacing="1" class="boxbg" style="width: 10in">
                                <tr bgcolor="#FFFFFF" id="Payment_detal_table8" runat="server" visible="false">
                                    <td colspan="6" align="center" class="bgbluegrey">
                                        <font class="blackfnt"><b>
                                            <asp:Button ID="Submitbtn" runat="server" Text="Submit Data" OnClientClick="javascript:return SubmitData('<%=totdoc.ToString() %>')"
                                                OnClick="Submitbtn_Click" />
                                        </b></font>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="paymentdetail" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="Submitbtn" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="chkCoddoc" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    <!-- #include  file="docket_javascript.aspx" -->
</asp:Content>
