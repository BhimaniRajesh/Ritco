<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_BILL_MR_Register_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
    
    
    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
	
	function SelectPartyCode()
     {
    
       // var ddl = document.getElementById('ctl00_MyCPH1_documet_type');
       // alert(ddl.value)
        if(document.getElementById("ctl00_MyCPH1_documet_type_0").checked ==true)
        {
            document.getElementById('ctl00_MyCPH1_tbl_BILL').style.display = "block";
            document.getElementById('ctl00_MyCPH1_tbl_CHK_BILL').style.display = "block";
            document.getElementById('ctl00_MyCPH1_tbl_CHK_MR').style.display = "none";
            document.getElementById('ctl00_MyCPH1_tbl_MR').style.display = "none";           
        }
        else if(document.getElementById("ctl00_MyCPH1_documet_type_1").checked ==true)
        {
       
            document.getElementById('ctl00_MyCPH1_tbl_BILL').style.display = "none";           
            document.getElementById('ctl00_MyCPH1_tbl_CHK_BILL').style.display = "none";            
            document.getElementById('ctl00_MyCPH1_tbl_CHK_MR').style.display = "block";
            document.getElementById('ctl00_MyCPH1_tbl_MR').style.display = "block";
            
        }
        
        
              
        //return false;
     }
     
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
     
     function CHKDKT1(val)
	{
	    
	    //alert("HIi")
	     var CHKDKT1=document.getElementById("ctl00_MyCPH1_CHKDKT1");
	    //alert(CHKDKT1.checked)
	    if(CHKDKT1.checked==true)
		{
		    for(im=0;im<23;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList1_"+im).checked = true;
		    }
	    }
	    if(CHKDKT1.checked==false)
		    {
		    for(im=0;im<23;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList1_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		   document.getElementById("ctl00_MyCPH1_CheckBoxList1_0").checked=true;
	    }
	}

function CHKDKT2(val)
	{
	    
	    //alert("HIi")
	     var CHKDKT1=document.getElementById("ctl00_MyCPH1_CHKDKT2");
	    //alert(CHKDKT1.checked)
	    if(CHKDKT1.checked==true)
		{
		    for(im=0;im<27;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList2_"+im).checked = true;
		    }
	    }
	    if(CHKDKT1.checked==false)
		    {
		    for(im=0;im<27;im++)
		    {
			    document.getElementById("ctl00_MyCPH1_CheckBoxList2_"+im).checked = false;
		    }
		    //document.form1.checkbox1.checked=true
		   document.getElementById("ctl00_MyCPH1_CheckBoxList2_0").checked=true;
	    }
	}
	
	function OnSub_DATACHECK()
     {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        /*if(!FinDateCheck())
            return false;       */      
     }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Invoice/Collection Register </strong> </font>
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
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Bill/MR Criteria</b></font>
                            </td>
                        </tr>
                        <tr id="Tr1"  runat="server" style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Documnet" runat="server"></asp:Label></td>
                            <td align="left" colspan="2" valign="top">
                                <%-- <asp:UpdatePanel ID="updatepanel3" runat="server">
                                    <ContentTemplate>--%> <asp:RadioButtonList ID="documet_type"  runat="server" RepeatDirection="horizontal" CssClass="blackfnt" OnClick="Javascript:return SelectPartyCode()" >
                                    <asp:ListItem Text="Bill" Selected="true" Value="B"></asp:ListItem>
                                    <asp:ListItem Text="MR" Value="M"></asp:ListItem>
                                </asp:RadioButtonList><%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select  </font>  <asp:dropdownlist id="DT_TYPE" runat="server">
         <asp:ListItem Text="Generation Date" Value="1" ></asp:ListItem>
         <asp:ListItem Text="Collection Date" Value="2" ></asp:ListItem>
         <asp:ListItem Text="Cancellation Date" Value="3" ></asp:ListItem>

                                </asp:dropdownlist> </font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                         <tr align="center" bgcolor="white">    
                            <td align="center">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td  align="Left" colspan="3">
                              <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="LT_CUST_VEND" Width="250" Height="100" SelectionMode="multiple"
                                            runat="server" CssClass="blackfnt"></asp:ListBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <%--<asp:ListItem Text="All" Value="All" Selected="True">
                                </asp:ListItem>--%--%>
                                 <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                            </tr>
                        <tr style="background-color: white" >
                        
                            <td align="left" colspan="7">
                            <!-- #include file="./SelectList_DKT.aspx"-->
                              <%--  <asp:UpdatePanel ID="updatepanel4" runat="server">
                                    <ContentTemplate>
                                        AutoPostBack="true" OnSelectedIndexChanged="documet_type_SelectedIndexChanged"
                                    
                                     </ContentTemplate>
                                <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />
                                
                                </Triggers>
                                </asp:UpdatePanel>--%>
                            </td>
                          
                           
                        </tr>
                        <tr style="background-color: white" >
                        
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
                            <td colspan="4">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="1"></asp:ListItem>
                                     <asp:ListItem Text="CSV Download" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return DateCheck();"--%>
                            </td>
                        </tr></table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white ;layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
