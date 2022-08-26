<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_OPS_StatusReprot_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="TRN" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster1" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="SVCTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster2" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="PAYTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster3" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="BUT" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

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
        
        
        function SELSTATUS()
        {
                var stTYP=document.getElementById("ctl00_MyCPH1_DLLTYP");
                if(stTYP.value=="1")
                {
                 document.getElementById('ctl00_MyCPH1_Tr3').style.display = "block";
                 document.getElementById('ctl00_MyCPH1_Tr4').style.display = "none";
                }
                else if(stTYP.value=="2")
                {
                  document.getElementById('ctl00_MyCPH1_Tr4').style.display = "block";
                  document.getElementById('ctl00_MyCPH1_Tr3').style.display = "none";
                }
                
        }
        
        
         function SELDAYS()
        {
                var stTYP=document.getElementById("ctl00_MyCPH1_DLLTYP_D");
               
                if(stTYP.value!="All" )
                {
                  document.getElementById('ctl00_MyCPH1_Tr5').style.display = "block";
                  
                }
                else
                {
                  document.getElementById('ctl00_MyCPH1_Tr5').style.display = "none";
                }
                
                if(stTYP.value!="3" )
                {
                  document.getElementById('ctl00_MyCPH1_Tr5').style.display = "block";
                }
                else
                {
                  document.getElementById('ctl00_MyCPH1_Tr5').style.display = "none";
                }
                
                var lbltext=""
                if(stTYP.value=="1" )
                {
                    lbltext=" (Day Diff Between EDD and ADD)"
                }
                 if(stTYP.value=="2" )
                {
                    lbltext=" (Day Diff Between EDD and ADD)"
                }
                
                document.getElementById('ctl00_MyCPH1_DLLDAYS_D').style.display = "block";
                 document.getElementById('ctl00_MyCPH1_DLLDAYS_U').style.display = "none";
                document.getElementById('ctl00_MyCPH1_daysdisc').innerText=lbltext;
        }
        
        function SELDAYS1()
        {
                var stTYP=document.getElementById("ctl00_MyCPH1_DLLTYP_U");
                if(stTYP.value!="All")
                {
                  document.getElementById('ctl00_MyCPH1_Tr5').style.display = "block";
                }
                else
                {
                  document.getElementById('ctl00_MyCPH1_Tr5').style.display = "none";
                }
                
                var lbltext=""
                if(stTYP.value=="1" )
                {
                    lbltext=" (Day Diff Between Booking Date and Today)"
                }
                 if(stTYP.value=="2" )
                {
                    lbltext=" (Day Diff Between Arrived Date and Today)"
                }
                 if(stTYP.value=="3" )
                {
                    lbltext=" (Day Diff Between Arrived Date (At Destination ) and Today)"
                }
                 if(stTYP.value=="4" )
                {
                    lbltext=" (Day Diff Between THC Date and Today)"
                }
                    document.getElementById('ctl00_MyCPH1_DLLDAYS_D').style.display = "none";
                document.getElementById('ctl00_MyCPH1_DLLDAYS_U').style.display = "block";
                document.getElementById('ctl00_MyCPH1_daysdisc').innerText=lbltext;
        }
        
        function ChkPgsize(val)
	{	
	     //pgSize=document.getElementById("ctl00_MyCPH1_pgSize"); 
	     if(document.getElementById("ctl00_MyCPH1_rptfrt_0").checked==true)
	    {
	     document.getElementById('ctl00_MyCPH1_TRPG').style.display = "block";
	    }
	    else 
	    {
	    document.getElementById('ctl00_MyCPH1_TRPG').style.display = "none";
	    }
	
	}
	
	function ChkPgsize1(val)
	{	
	     //pgSize=document.getElementById("ctl00_MyCPH1_pgSize"); 
	     if(document.getElementById("ctl00_MyCPH1_DLLRPTTYP_0").checked==true)
	    {
	     document.getElementById('ctl00_MyCPH1_TRPG').style.display = "block";
	    }
	    else 
	    {
	    document.getElementById('ctl00_MyCPH1_TRPG').style.display = "none";
	    }
	
	}
        function OnSub_DATACHECK()
        {
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        //if(!FinDateCheck())
        //    return false;             
     }
        
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Operation Performance Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" cellpadding="3" style="width: 8.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Documnets Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="DT_TYPE" runat="server">
                                        <asp:ListItem Text="Origin" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Current" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Delivery" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                    Location</font>
                            </td>
                            <td align="left">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Date</font> </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="dkttr1" runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <font class="blackfnt">Select Paybas</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboPaybas" DataSourceID="MySQLDataSource_GeneralMaster2"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr2" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Mode</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboMode" DataSourceID="MySQLDataSource_GeneralMaster"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr3" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Service Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboType" DataSourceID="MySQLDataSource_GeneralMaster1"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr4" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Business Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboBUTType" DataSourceID="MySQLDataSource_GeneralMaster3"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Tr2" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Delivered/Undelivered</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DLLTYP" runat="server" CssClass="blackfnt" OnChange="Javascript:return SELSTATUS();">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Delivered" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="UnDelivered" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                                
                               
                            </td>
                        </tr>
                        <tr id="Tr3" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Status</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DLLTYP_D" runat="server" CssClass="blackfnt" OnChange="Javascript:return SELDAYS();" Style="display: block;">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Late" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Eary" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="On Time" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr id="Tr4" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Status</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="DLLTYP_U" runat="server" CssClass="blackfnt" OnChange="Javascript:return SELDAYS1();"  Style="display: block;">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Booking Stock" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Transhipment Stock" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Delivery Stock" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="In Transit Stock" Value="4"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                         <tr id="Tr5" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Days</font>
                                <asp:Label id="daysdisc" runat="server"  CssClass="bluefnt" ></asp:Label>
                            </td>
                            <td align="left">
                                 <asp:DropDownList ID="DLLDAYS_D" runat="server" CssClass="blackfnt" Style="display: block;">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text=">3" Value=">3"></asp:ListItem>
                                </asp:DropDownList>
                                
                                 <asp:DropDownList ID="DLLDAYS_U" runat="server" CssClass="blackfnt" Style="display: block;">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text=">3" Value=">3"></asp:ListItem>
                                </asp:DropDownList>
                           
                            </td>
                        </tr>
                        
                        <tr align="left" style="background-color: white;">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="Tr7" runat="server" style="background-color: white; display: block;">
                            <td colspan="2" align="center">
                             <asp:Label ID="Label2" CssClass="blackboldfnt" Text="OR" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr6" runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                         <tr align="center" bgcolor="white">
                                        <td colspan="6">
                                            <asp:RadioButtonList ID="DLLRPTTYP" onClick="javascript:ChkPgsize1(this);" RepeatDirection="horizontal" CssClass="blackfnt"
                                                runat="server">
                                                <asp:ListItem Selected="True" Text="Register" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Summary" Value="2"></asp:ListItem>
                                                
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                          <tr align="center" bgcolor="white">
                                        <td colspan="6">
                                            <asp:RadioButtonList ID="rptfrt" onClick="javascript:ChkPgsize(this);" RepeatDirection="horizontal" CssClass="blackfnt"
                                                runat="server">
                                                <asp:ListItem Selected="True" Text="HTML Format" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="XLS Format" Value="2"></asp:ListItem>
                                                
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr align="center"  id="TRPG" runat="Server" bgcolor="white" style=" display:block;">
                                        <td colspan="6">
                                        <font class="blackfnt">Select Page Size </font>
                                            <asp:DropDownList ID="pgSize" CssClass="blackfnt" runat="server">
                                                <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                                <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                                <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Submit" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
