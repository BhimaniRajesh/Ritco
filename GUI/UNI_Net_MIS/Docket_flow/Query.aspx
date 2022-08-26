<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Docket_flow_Query" %>

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

       <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>
<div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Docket Flow Report</strong> </font>
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
                                       
                                        <asp:ListItem Text="Destination" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                    Location</font>
                            </td>
                            <td align="left">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Date</font> 
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
                        <tr align="center"  id="TRPG" runat="Server" bgcolor="white" style=" display:block;">
                                        <td align="Left">
                                <font class="blackfnt">Select Status</font>
                            </td>
                            <td align="left">
                                       
                                            <asp:DropDownList ID="DLLStatus" CssClass="blackfnt" runat="server">
                                             <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                                <asp:ListItem Text="Booked" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="NOT departed from booking location" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Departed from Booking Location" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="In Transit" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="At Transshipment Location" Value="5"></asp:ListItem>
                                                <asp:ListItem Text="Arrived At Delivery location" Value="6"></asp:ListItem>
                                                <asp:ListItem Text="Delivered" Value="7"></asp:ListItem>
                                                <asp:ListItem Text="Not Delivered" Value="8"></asp:ListItem>
                                                <asp:ListItem Text="Delivery attempted" Value="9"></asp:ListItem>
                                                <asp:ListItem Text="Failed Delivery" Value="10"></asp:ListItem>
                                                <asp:ListItem Text="Delivery NOT attempted" Value="11"></asp:ListItem>
                                                <asp:ListItem Text="Failed Delivery At Arrived Time" Value="12"></asp:ListItem>
                                                <asp:ListItem Text="Delivered- on time" Value="13"></asp:ListItem>
                                                <asp:ListItem Text="Delivered- late" Value="14"></asp:ListItem>
                                                <asp:ListItem Text="Delivered- before time" Value="15"></asp:ListItem>
                                             
                                            </asp:DropDownList>
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
