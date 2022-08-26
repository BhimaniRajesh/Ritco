<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_Monthly_Sales_query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="JavaScript" SRC="./../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="./../../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function ChkRadio(obj)
	{
	 //alert(document.getElementById("ctl00_MyCPH1_rdMonth_9").checked)
	 //var rdMonth=document.getElementById("ctl00_MyCPH1_rdMonth");
	 var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
	 var ddYear=document.getElementById("ctl00_MyCPH1_ddYear");
     var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
	 var lblFrom=document.getElementById("ctl00_MyCPH1_lblFrom");
	 var lblTo=document.getElementById("ctl00_MyCPH1_lblTo");
	
	    if (document.getElementById("ctl00_MyCPH1_rdMonth_9").checked==true)
         {
             txtDateFrom.disabled=false
             txtDateTo.disabled=false
             lblFrom.disabled=false
             lblTo.disabled=false
             
         }
         else
         {
             txtDateFrom.disabled=true
             txtDateTo.disabled=true
             lblFrom.disabled=true
             lblTo.disabled=true
         }
         
         if (document.getElementById("ctl00_MyCPH1_rdMonth_0").checked==true||document.getElementById("ctl00_MyCPH1_rdMonth_1").checked==true||document.getElementById("ctl00_MyCPH1_rdMonth_7").checked==true||document.getElementById("ctl00_MyCPH1_rdMonth_8").checked==true||document.getElementById("ctl00_MyCPH1_rdMonth_9").checked==true)
         {
         ddYear.disabled=true
         }
         else
         {
         ddYear.disabled=false
         }
	
	}
	
	function chkall1(val)
	{
	    ij="<%=payint%>"
	     //alert(ij)
	     var ChkAmtChrgAll=document.getElementById("ctl00_MyCPH1_ChkAmtChrgAll");
	    //alert(ChkAmtChrgAll.checked)
	    if(ChkAmtChrgAll.checked==true)
		{
		
		    for(i=0;i<ij-1;i++)
		    {
		    //alert("Hi..")
			    document.getElementById("ctl00_MyCPH1_ChkPaybas_"+i).checked = true;
			   /// alert(document.getElementById("ctl00_MyCPH1_ChkPaybas_"+i).checked)
		    }
	    }
	    if(ChkAmtChrgAll.checked==false)
		    {
		    for(i=0;i<ij-1;i++)
		    {
			    document.getElementById("ctl00_MyCPH1_ChkPaybas_"+i).checked = false;
		    }
		    document.getElementById("ctl00_MyCPH1_ChkPaybas_0").checked=true;
	    }
	}
	
	function chkall2(val)
	{
	    ik="<%=trnint%>"
	    //alert(ik)
	     var Chktrnmod=document.getElementById("ctl00_MyCPH1_Chktrnmod");
	    //alert(ChkAmtChrgAll.checked)
	    if(Chktrnmod.checked==true)
		{
		    for(im=0;im<ik-1;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxListTrn_"+im).checked = true;
		    }
	    }
	    if(Chktrnmod.checked==false)
		    {
		    for(im=0;im<ik-1;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxListTrn_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		    // document.getElementById("ctl00_MyCPH1_ChkPaybas_"+ik-2).checked=true;
	    }
	}
	
	function YearChange()
	{
	   ddYear=document.getElementById("ctl00_MyCPH1_ddYear"); 
	    //alert(document.getElementById("ctl00_MyCPH1_rdMonth_6").value)
	   document.getElementById("ctl00_MyCPH1_rdMonth_6").Text="Year";
	  
	   if(ddYear.value=="<%=selyear%>")
	   {
	   //alert("Hi...")
	    document.getElementById("ctl00_MyCPH1_rdMonth_0").disabled=false
	        document.getElementById("ctl00_MyCPH1_rdMonth_1").disabled=false
	        document.getElementById("ctl00_MyCPH1_rdMonth_6").checked=false
	        document.getElementById("ctl00_MyCPH1_rdMonth_0").checked=true
	   }
	   else
	   {//alert("Hi..No.")
	        document.getElementById("ctl00_MyCPH1_rdMonth_0").disabled=true
	        document.getElementById("ctl00_MyCPH1_rdMonth_1").disabled=true
	        document.getElementById("ctl00_MyCPH1_rdMonth_6").checked=true
	   }
	
	}
	
	
	function ChkCust(val)
	{
	    ChkCust8888=document.getElementById("ctl00_MyCPH1_ChkCust8888"); 
	     //alert(ChkCust8888.disabled)
	    //alert(document.getElementById("ctl00_MyCPH1_rpttyp_1").checked)
	    if(document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true)
	    {
	    //ChkCust8888.checked=true
	    //alert("hi")
	     ChkCust8888.disabled=false;
	    }
	    else
	    {
	    ChkCust8888.disabled=true;
	    //ChkCust8888.checked=false
	    }
	}
	
	
	function DateCheck()
{
     //var Selection=document.getElementById("ctl00_MyCPH1_radDate_0");
     var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
     var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
     
     // var txtcustcd=document.getElementById("ctl00_MyCPH1_txtcustcd");
      // var txtvendcd=document.getElementById("ctl00_MyCPH1_txtvendcd");
      //  var DLLOrder=document.getElementById("ctl00_MyCPH1_DLLOrder");
     
    
     if (document.getElementById("ctl00_MyCPH1_rdMonth_9").checked==true)
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
    <br />
    <br />
    <br />
    <div align="left">
        <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="5" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center">
                    <%--<asp:UpdatePanel ID="UpdatePanel5"              UpdateMode="Conditional" runat="server">
                        <ContentTemplate>OnSelectedIndexChanged="ddYear_SelectedIndexChanged"  AutoPostBack="true"--%>
                            <asp:Label ID="lblselmonthCri"  CssClass="blackfnt" Text="Select Month/Year" runat="server"></asp:Label>
                            <asp:DropDownList ID="ddYear" Enabled="false" runat="server"  onChange="Javascript:YearChange();" 
                               >
                            </asp:DropDownList><br />
                            <br />
                             <asp:Label ID="lblmonthname" Visible="false" CssClass="blackfnt" runat="server"></asp:Label>
                            <%--<center>--%>
                                <%-- <asp:UpdatePanel ID="UpdatePanel5"              UpdateMode="Conditional" runat="server">
                            <ContentTemplate>--%>
                               <%--<%-- <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressArea">
                                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <%--  </ContentTemplate>
                        </asp:UpdatePanel>--%>
                            <%--</center>
                           
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rdMonth" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                </td>
                <td align="left" colspan="2">
                  <%--  <asp:UpdatePanel ID="UpdatePanel1"            UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>OnSelectedIndexChanged="rdMonth_SelectedIndexChanged" AutoPostBack="true" --%>
                            <asp:RadioButtonList ID="rdMonth" RepeatColumns="3" RepeatDirection="Horizontal"
                            onClick="javascript:ChkRadio(this);"
                                runat="server" CssClass="blackfnt" >
                                <asp:ListItem Text="Current Month" Selected="true" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Previous  Month" Value="2"></asp:ListItem>
                                <asp:ListItem Text="First  Quarter" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Sencond Quarter" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Third  Quarter" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Fourth Quarter" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Year" Value="7"></asp:ListItem>
                                <asp:ListItem Text="Today" Value="8"></asp:ListItem>
                                <asp:ListItem Text="Last Week (including today)" Value="9"></asp:ListItem>
                                <asp:ListItem Text="Date Range" Value="10"></asp:ListItem>
                               
                            </asp:RadioButtonList>&nbsp;&nbsp;&nbsp;&nbsp;
                             <asp:Label ID="lblFrom" Enabled="false" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" Enabled="false" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox>
                                     <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img  src="./../../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label Enabled="false" ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox Enabled="false" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A>
                      <%--  </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddYear" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                </td>
            </tr>
            <tr id="ROWLO" visible="true" runat="server" style="background-color: white">
                <td align="left">
                    <asp:Label ID="Label8" CssClass="blackfnt" Text="Select RO" runat="server" Width="100%"></asp:Label>
                </td>
                <td align="left" valign="top">
                    <asp:UpdatePanel ID="UP" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged">
                                <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <%--<td align="left" valign="top">
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_TO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO">
                                <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>--%>
            </tr>
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="Label7" CssClass="blackfnt" Text="Select Location" runat="server"
                        Width="102px"></asp:Label>
                </td>
                <td align="left" valign="top">
                    <asp:UpdatePanel ID="updatepanel8" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_Lo" runat="server"  Mode="Conditional"
                                RenderMode="Inline" Width="102px">
                                <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <%--<td align="left" valign="top">
                    <asp:UpdatePanel ID="updatepanel9" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_Lo_TO" runat="server"  Mode="Conditional"
                                RenderMode="Inline" Width="102px">
                                <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO_TO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>--%>
            </tr>
            <tr bgcolor="white">
                <td>
                
                 <%--<asp:UpdatePanel ID="UpdatePanel12" RenderMode="Inline"       UpdateMode="Conditional" runat="server">
                 
                                <ContentTemplate>OnCheckedChanged="ChkAmtChrgAll_Checked" AutoPostBack="true"--%>
                                  <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Paybas" runat="server" Width="102px"></asp:Label> &nbsp;&nbsp;&nbsp;
                                    <asp:CheckBox Text=" All"  onClick="chkall1(this.value);" CssClass="blackfnt"  ID="ChkAmtChrgAll" runat="server"  />
                               <%-- </ContentTemplate>
                            </asp:UpdatePanel>--%>
                  
                    </td>
                <td colspan="2">
                    <%--<asp:UpdatePanel ID="UpdatePanel13" RenderMode="Inline"      UpdateMode="Conditional" runat="server">
                        <ContentTemplate>--%>
                            <asp:CheckBoxList ID="ChkPaybas"    runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                TextAlign="Right" CellPadding="2" CellSpacing="2">
                            </asp:CheckBoxList>
                       <%-- </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ChkAmtChrgAll" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                </td>
            </tr>
            
             <tr bgcolor="white">
                <td>
                
              <%--   <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"     UpdateMode="Conditional" runat="server">
                 
                                <ContentTemplate>--%>
                                  <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Mode" runat="server" Width="102px"></asp:Label> &nbsp;&nbsp;&nbsp;
                                    <asp:CheckBox Text=" All"  onClick="chkall2(this.value);" CssClass="blackfnt"  ID="Chktrnmod" runat="server"  />
                                <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
                  
                    </td>
                <td colspan="2">
                  <%--  <asp:UpdatePanel ID="UpdatePanel6" RenderMode="Inline"    UpdateMode="Conditional" runat="server">AutoPostBack="true"OnCheckedChanged="Chktrnmod_Checked" 
                        <ContentTemplate>--%>
                            <asp:CheckBoxList ID="CheckBoxListTrn"  runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                TextAlign="Right" CellPadding="2" CellSpacing="2">
                            </asp:CheckBoxList>
                      <%--  </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Chktrnmod" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>--%>
                </td>
            </tr>
            
            <tr bgcolor="white"  >
                <td>
                
                 <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"   UpdateMode="Conditional" runat="server">
                 
                                <ContentTemplate>
                                  <asp:Label ID="Label2" CssClass="blackfnt" Text="Select OutPut" runat="server" Width="102px"></asp:Label> &nbsp;&nbsp;&nbsp;
                                    <asp:CheckBox Text=" All" CssClass="blackfnt" Enabled="False"  Checked="true"  AutoPostBack="true" ID="Chkoutput" runat="server" OnCheckedChanged="Chkoutput_Checked"  />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                  
                    </td>
                <td colspan="2">
                    <asp:UpdatePanel ID="UpdatePanel3" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:CheckBoxList ID="CheckBoxListPouput" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                TextAlign="Right" CellPadding="2" CellSpacing="2">
                                <asp:ListItem  Enabled="False" Selected="true" Text="Number of Dockets" Value="totdkts"></asp:ListItem>
                                 <asp:ListItem  Enabled="False"  Selected="true" Text="Docket Charged Weight " Value="totchrgwt"></asp:ListItem>
                                  <asp:ListItem  Enabled="False"  Selected="true"  Text="Docket Total " Value="dkttot"></asp:ListItem>
                                   <asp:ListItem Enabled="False"   Selected="true"  Text="Yield" Value="clyield"></asp:ListItem>
                            </asp:CheckBoxList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Chkoutput" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td  colspan="3">
                <asp:RadioButtonList  ID="rptSubtyp" RepeatDirection="horizontal" CssClass="blackfnt"  runat="server">
                <asp:ListItem  Selected="True" Text="Paybas Wise" Value="1"></asp:ListItem>
                <asp:ListItem   Text="Mode Wise" Value="2"></asp:ListItem>
                 
                </asp:RadioButtonList>
                
                 <asp:CheckBox Text="Custmoer Code - 8888" CssClass="blackfnt"    ID="ChkCust8888" runat="server"  />
                 </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td  colspan="3">
                <asp:RadioButtonList onClick="javascript:ChkCust(this);"  ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"  runat="server">
                <asp:ListItem   Text="Location Wise" Value="1"></asp:ListItem>
                <asp:ListItem  Selected="True" Text="Customer Wise" Value="2"></asp:ListItem>
                 <asp:ListItem   Text="Customer Group Wise" Value="3"></asp:ListItem>
                  <asp:ListItem   Text="Entry Person Wise" Value="4"></asp:ListItem>
                  <asp:ListItem   Text="Lost Customer Wise" Value="5"></asp:ListItem>
                    <asp:ListItem   Text="Top 20 Customer " Value="6"></asp:ListItem>
                   <asp:ListItem   Text="Employee/BA Wise" Value="7"></asp:ListItem>
                </asp:RadioButtonList>
                 </td>
            </tr>
            <tr bgcolor="white"> <td  colspan="3"></td></tr>
            <tr align="center" bgcolor="white">
                <td  colspan="3">
                <asp:Button  ID="btnShow" OnClientClick="Javascript: return DateCheck()" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                 </td>
            </tr>
        </table>
    </div>
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content>
