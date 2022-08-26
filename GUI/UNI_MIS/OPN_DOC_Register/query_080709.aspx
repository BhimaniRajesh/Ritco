<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_OPN_DOC_Register_query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();



function CHKDKT1(val)
	{
	    
	    //alert(ik)
	     var CHKDKT1=document.getElementById("ctl00_MyCPH1_CHKDKT1");
	    //alert(ChkAmtChrgAll.checked)
	    if(CHKDKT1.checked==true)
		{
		    for(im=0;im<32;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList1_"+im).checked = true;
		    }
	    }
	    if(CHKDKT1.checked==false)
		    {
		    for(im=0;im<32;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList1_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function CHKDKT2(val)
	{
	    ij="<%=chgV%>"
	     //alert(ij)
	     var CHKDKT2=document.getElementById("ctl00_MyCPH1_CHKDKT2");
	    //alert(ChkAmtChrgAll.checked)
	    if(CHKDKT2.checked==true)
		{
		
		    for(i=0;i<ij;i++)
		    {
		    //alert("Hi..")
			    document.getElementById("ctl00_MyCPH1_ChkAmtChrgDtl_"+i).checked = true;
			   /// alert(document.getElementById("ctl00_MyCPH1_ChkPaybas_"+i).checked)
		    }
	    }
	    if(CHKDKT2.checked==false)
		    {
		    for(i=0;i<ij;i++)
		    {
			    document.getElementById("ctl00_MyCPH1_ChkAmtChrgDtl_"+i).checked = false;
		    }
		    
	    }
	}

function CHKDKT3(val)
	{
	    
	    //alert(ik)
	     var CHKDKT3=document.getElementById("ctl00_MyCPH1_CHKDKT3");
	    //alert(ChkAmtChrgAll.checked)
	    if(CHKDKT3.checked==true)
		{
		    for(im=0;im<5;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList3_"+im).checked = true;
		    }
	    }
	    if(CHKDKT3.checked==false)
		    {
		    for(im=0;im<5;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList3_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function CHKDKT4(val)
	{
	    
	    //alert(ik)
	     var CHKDKT4=document.getElementById("ctl00_MyCPH1_CHKDKT4");
	    //alert(ChkAmtChrgAll.checked)
	    if(CHKDKT4.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList4_"+im).checked = true;
		    }
	    }
	    if(CHKDKT4.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList4_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}

function THCHK1(val)
	{
	    
	    //alert(ik)
	     var THCHK1=document.getElementById("ctl00_MyCPH1_THCHK1");
	    //alert(ChkAmtChrgAll.checked)
	    if(THCHK1.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST1_"+im).checked = true;
		    }
	    }
	    if(THCHK1.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST1_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function THCHK2(val)
	{
	    
	    //alert(ik)
	     var THCHK2=document.getElementById("ctl00_MyCPH1_THCHK2");
	    //alert(ChkAmtChrgAll.checked)
	    if(THCHK2.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST2_"+im).checked = true;
		    }
	    }
	    if(THCHK2.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST2_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function THCHK3(val)
	{
	    
	    //alert(ik)
	     var THCHK3=document.getElementById("ctl00_MyCPH1_THCHK3");
	    //alert(ChkAmtChrgAll.checked)
	    if(THCHK3.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST3_"+im).checked = true;
		    }
	    }
	    if(THCHK3.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST3_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function THCHK4(val)
	{
	    
	    //alert(ik)
	     var THCHK4=document.getElementById("ctl00_MyCPH1_THCHK4");
	    //alert(ChkAmtChrgAll.checked)
	    if(THCHK4.checked==true)
		{
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST4_"+im).checked = true;
		    }
	    }
	    if(THCHK4.checked==false)
		    {
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST4_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function THCHK5(val)
	{
	    
	    //alert(ik)
	     var THCHK1=document.getElementById("ctl00_MyCPH1_THCHK5");
	    //alert(ChkAmtChrgAll.checked)
	    if(THCHK1.checked==true)
		{
		    for(im=0;im<11;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST5_"+im).checked = true;
		    }
	    }
	    if(THCHK1.checked==false)
		    {
		    for(im=0;im<11;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_THCCHKLIST5_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	
	
	function PRSHK1(val)
	{
	    
	    //alert(ik)
	     var PRSHK1=document.getElementById("ctl00_MyCPH1_PRSHK1");
	    //alert(ChkAmtChrgAll.checked)
	    if(PRSHK1.checked==true)
		{
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST1_"+im).checked = true;
		    }
	    }
	    if(PRSHK1.checked==false)
		    {
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST1_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function PRSHK2(val)
	{
	    
	    //alert(ik)
	     var PRSHK2=document.getElementById("ctl00_MyCPH1_PRSHK2");
	    //alert(ChkAmtChrgAll.checked)
	    if(PRSHK2.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST2_"+im).checked = true;
		    }
	    }
	    if(PRSHK2.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST2_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function PRSHK3(val)
	{
	    
	    //alert(ik)
	     var PRSHK3=document.getElementById("ctl00_MyCPH1_PRSHK3");
	    //alert(ChkAmtChrgAll.checked)
	    if(PRSHK3.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST3_"+im).checked = true;
		    }
	    }
	    if(PRSHK3.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST3_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function PRSHK4(val)
	{
	    
	    //alert(ik)
	     var PRSHK4=document.getElementById("ctl00_MyCPH1_PRSHK4");
	    //alert(ChkAmtChrgAll.checked)
	    if(PRSHK4.checked==true)
		{
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST4_"+im).checked = true;
		    }
	    }
	    if(PRSHK4.checked==false)
		    {
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST4_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function PRSHK5(val)
	{
	    
	    //alert(ik)
	     var PRSHK1=document.getElementById("ctl00_MyCPH1_PRSHK5");
	    //alert(ChkAmtChrgAll.checked)
	    if(PRSHK1.checked==true)
		{
		    for(im=0;im<10;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST5_"+im).checked = true;
		    }
	    }
	    if(PRSHK1.checked==false)
		    {
		    for(im=0;im<10;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_PRSCHKLIST5_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}



function DRSHK1(val)
	{
	    
	    //alert(ik)
	     var DRSHK1=document.getElementById("ctl00_MyCPH1_DRSHK1");
	    //alert(ChkAmtChrgAll.checked)
	    if(DRSHK1.checked==true)
		{
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST1_"+im).checked = true;
		    }
	    }
	    if(DRSHK1.checked==false)
		    {
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST1_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function DRSHK2(val)
	{
	    
	    //alert(ik)
	     var DRSHK2=document.getElementById("ctl00_MyCPH1_DRSHK2");
	    //alert(ChkAmtChrgAll.checked)
	    if(DRSHK2.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST2_"+im).checked = true;
		    }
	    }
	    if(DRSHK2.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST2_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function DRSHK3(val)
	{
	    
	    //alert(ik)
	     var DRSHK3=document.getElementById("ctl00_MyCPH1_DRSHK3");
	    //alert(ChkAmtChrgAll.checked)
	    if(DRSHK3.checked==true)
		{
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST3_"+im).checked = true;
		    }
	    }
	    if(DRSHK3.checked==false)
		    {
		    for(im=0;im<9;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST3_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function DRSHK4(val)
	{
	    
	    //alert(ik)
	     var DRSHK4=document.getElementById("ctl00_MyCPH1_DRSHK4");
	    //alert(ChkAmtChrgAll.checked)
	    if(DRSHK4.checked==true)
		{
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST4_"+im).checked = true;
		    }
	    }
	    if(DRSHK4.checked==false)
		    {
		    for(im=0;im<6;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST4_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function DRSHK5(val)
	{
	    
	    //alert(ik)
	     var DRSHK1=document.getElementById("ctl00_MyCPH1_DRSHK5");
	    //alert(ChkAmtChrgAll.checked)
	    if(DRSHK1.checked==true)
		{
		    for(im=0;im<3;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST5_"+im).checked = true;
		    }
	    }
	    if(DRSHK1.checked==false)
		    {
		    for(im=0;im<3;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST5_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}



function DRSHK6(val)
	{
	    
	    //alert(ik)
	     var DRSHK6=document.getElementById("ctl00_MyCPH1_DRSHK6");
	    //alert(ChkAmtChrgAll.checked)
	    if(DRSHK6.checked==true)
		{
		    for(im=0;im<12;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST6_"+im).checked = true;
		    }
	    }
	    if(DRSHK6.checked==false)
		    {
		    for(im=0;im<12;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_DRSCHKLIST6_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	
	function DateCheck()
{
     var Selection=document.getElementById("ctl00_MyCPH1_radDate_0");
     var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
     var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
     
      var SelDOc=document.getElementById("ctl00_MyCPH1_documet_type");
    
     if(SelDOc.value=="S")
		 {
		  alert("Please Select One Document")
		  SelDOc.focus();
		  return false;
		 }
     
     if (document.getElementById("ctl00_MyCPH1_radDate_0").checked==true)
     {
        if(txtDateFrom.value=="")
		 {
		  alert("Please enter the From Date")
		  txtDateFrom.focus();
		  return false;
		 }
		 if(txtDateFrom.value!="")
							 {
									if (ValidateForm(txtDateFrom)==false)
									{
									 return false;
									}
							 }
		 if(txtDateTo.value=="")
		 {
		  alert("Please enter the To Date")
		  txtDateTo.focus();
		  return false;
		 }
		 
		 if(txtDateTo.value!="")
							 {
									if (ValidateForm(txtDateTo)==false)
									{
									 return false;
									}
							}
     
     }
}
    </script>
  <div align="center">
 <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                    <ContentTemplate>
                                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." ForeColor="red" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
</div>
    <br />
    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>Operation Document Register</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
<img alt="Back" src="./../../images/back.gif" border="0"> </a>
</td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                            </td>
                        </tr>
                        
                        <tr style="background-color: white">
                            <td colspan="7" align="center" style="height: 21px">
                               <asp:RadioButtonList    ID="rptfrt" RepeatDirection="horizontal" CssClass="blackfnt"  runat="server">
                <asp:ListItem Selected="True"  Text="HTML Format" Value="1"></asp:ListItem>
                <asp:ListItem   Text="XLS Format" Value="2"></asp:ListItem>
                <asp:ListItem   Text="CSV Format" Value="3"></asp:ListItem>
                </asp:RadioButtonList>
                            </td>
                        </tr> 
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type" runat="server"></asp:Label></td>
                            <td align="left" colspan="5" valign="top">
                                <asp:UpdatePanel ID="updatepanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="documet_type" runat="server" AutoPostBack="true" OnSelectedIndexChanged="documet_type_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr id="ROWLO" visible="true" runat="server" style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:Label ID="Label8" CssClass="blackfnt" Text="Select RO" runat="server"></asp:Label>
                            </td>
                            <td align="left" colspan="2" valign="top">
                                <asp:UpdatePanel ID="UP" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cboRO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged">
                                            <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cboRO_TO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO">
                                            <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="2" align="left">
                                <asp:Label ID="Label7" CssClass="blackfnt" Text="Select Location" runat="server"></asp:Label>
                            </td>
                            <td align="left" colspan="2" valign="top">
                                <asp:UpdatePanel ID="updatepanel8" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cboRO_Lo" runat="server" Mode="Conditional" RenderMode="Inline"
                                            Width="102px">
                                            <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO" --%>
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:UpdatePanel ID="updatepanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cboRO_Lo_TO" runat="server" AutoPostBack="true" Mode="Conditional"
                                            RenderMode="Inline" Width="102px">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                            <tr style="background-color: white">
                                <td align="left">
                                    <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        Width="210px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                                    </asp:RadioButtonList>
                                </td>
                                <td valign="top" align="right" colspan="5">
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                                        MaxLength="10"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                        name="anchor1" id="anchor1">
                                        <img src="./../../images/calendar.jpg" border="0"></img>
                                    </a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60"
                                        MaxLength="10"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                        name="anchor2" id="a1">
                                        <img src="./../../images/calendar.jpg" border="0"></img>
                                    </a>
                                </td>
                            </tr>
                        </tr>
                        
                        
                        
                        
                        
                          
                        
                        <tr style="background-color: white" >
                        
                            <td align="left" colspan="7">
                                <asp:UpdatePanel ID="updatepanel4" runat="server">
                                    <ContentTemplate>
                                        <!-- #include file="./SelectList_DKT.aspx"-->
                                    
                                     </ContentTemplate>
                                <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />
                                
                                </Triggers>
                                </asp:UpdatePanel>
                            </td>
                          
                           
                        </tr>
                       
                       
                        
                         
                        
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td colspan="7">
                                <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                                <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                       
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                               <%-- <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>--%>
                            </td>
                        </tr>
                        <%--  <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Text=" Document No(s). (Manual No./Invoice No.):� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtmanbo" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label9" CssClass="blackfnt" runat="server" Text=" Customer Ref. No./Vehicle No. :�� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtCustRefno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label10" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label11" CssClass="blackfnt" runat="server" Text=" Free Text :�� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtFreeText" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[Insert Remak Word]</font>
                </td>
            </tr>--%> <tr style="background-color: white" >
                        
                            <td align="left" colspan="7">
                                <asp:UpdatePanel ID="updatepanel5" runat="server">
                                    <ContentTemplate>
                                        <!-- #include file="./CHKLIST_DKT.aspx"-->
                                    
                                     </ContentTemplate>
                                <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />
                                
                                </Triggers>
                                </asp:UpdatePanel>
                            </td>
                          
                           
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
<%--OnClick="btnShow_Click"--%>
