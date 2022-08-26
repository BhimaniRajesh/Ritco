<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_BIll_MR_Register_ver1_Query" %>
    
<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" 
    SelectCommand="Select CodeID='All', CodeDesc='--All--'    Union   Select CodeID, CodeDesc From WebX_Master_General where CodeType IN ('BILLTYP','MRSTYPE') AND LEFT(CodeType,1)=@BM order by CodeDesc"
        SelectCommandType="Text">
        <SelectParameters>
            <asp:ControlParameter Name="BM" Type="String" ControlID="documet_type" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="MySQLDataSource_BILLCHARGES" runat="server" SelectCommand="Webxnet_BILL_MR_REgister_Charges"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="TYP" Type="String" ControlID="documet_type" />
           <asp:ControlParameter Name="BM_TY" Type="String" ControlID="Bill_Type" />          
        </SelectParameters>
    </asp:SqlDataSource>
    
        
    <asp:SqlDataSource ID="MySQLDataSource_CLLIST_ALL_BILL" runat="server" SelectCommand="Webxnet_BILL_MR_REgister_Charges_CLLIST"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="TYP" Type="String" ControlID="documet_type" />
           <asp:ControlParameter Name="BM_TY" Type="String" ControlID="Bill_Type" />          
        </SelectParameters>
    </asp:SqlDataSource>
    
      

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
        
        function OnSub_DATACHECK()
         {
        
            if(!DateCheck())
                return false;
          //  alert("HIii")
            /*if(!FinDateCheck())
                return false;       */      
         }
         
          function OTH_FILEDS(N_B)
         {    
               document.getElementById('ctl00_MyCPH1_TR_BM1').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM2').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM3').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM4').style.display = N_B;   
               document.getElementById('ctl00_MyCPH1_TR_BILL1').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM5').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM6').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM7').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_BM8').style.display = N_B;   
               document.getElementById('ctl00_MyCPH1_TR_BM9').style.display = N_B;         
         }
            
          function MR_FILEDS(N_B)
         {    
              // document.getElementById('ctl00_MyCPH1_TR_MR1').style.display = N_B;
               document.getElementById('ctl00_MyCPH1_TR_MR2').style.display = N_B;
               
              //   document.getElementById('ctl00_MyCPH1_TR_MRCL1').style.display = N_B;
              // document.getElementById('ctl00_MyCPH1_TR_MRCL2').style.display = N_B;
         }
         function BILL_FILEDS(N_B1)
         {    
              // 
               document.getElementById('ctl00_MyCPH1_TR_BILL2').style.display = N_B1;
               document.getElementById('ctl00_MyCPH1_TR_BILL3').style.display = N_B1;
               document.getElementById('ctl00_MyCPH1_TR_BILL4').style.display = N_B1;
               
          
         }
         
         function CHARGES_FILEDS(N_B1)
         {document.getElementById('ctl00_MyCPH1_TR_BILLCL1').style.display = N_B1;
               document.getElementById('ctl00_MyCPH1_TR_BILLCL2').style.display = N_B1;
                 document.getElementById('ctl00_MyCPH1_TR_BILLCL4').style.display = N_B1;
               document.getElementById('ctl00_MyCPH1_TR_BILLCL3').style.display = N_B1;
         }
         
         
          function ShowDKTColumns() 
           {
              CHARGES_FILEDS('block');
           }
           
            function HideDKTColumns() 
           {
                CHARGES_FILEDS('none');
           }
           
           
           function ShowDKTFilter() 
           { //alert("Hiiiiiiii")
           
                HideDKTFilter();
                SelectPartyCode();
                OTH_FILEDS('block');
           }
           
           function HideDKTFilter() 
           {
              MR_FILEDS('none');  
              BILL_FILEDS('none'); 
              OTH_FILEDS('none');
           }
         
        function SelectPartyCode()
         {    
            
      
            if(document.getElementById("ctl00_MyCPH1_documet_type_0").checked ==true)
            {
           // alert("Hiiiiiiii")
               BILL_FILEDS('block');                
               MR_FILEDS('none') ;              
                        
            }
            else if(document.getElementById("ctl00_MyCPH1_documet_type_1").checked ==true)
            { 
            //alert("Hiiiiiiii ___________1")
                BILL_FILEDS('none') ;
                 MR_FILEDS('block');
            }
            
                
        }
        
    function CHKDKT1(val)
	{
	    ij="<%=CHKBOXLIST1.Items.Count%>"
	    
	     var CHKDKT1=document.getElementById("ctl00_MyCPH1_CHKDKT1");
	   
	    if(CHKDKT1.checked==true)
		{		
		    for(i=0;i<ij;i++)
		    {
	    document.getElementById("ctl00_MyCPH1_CHKBOXLIST1_"+i).checked = true;			   
		    }
	    }
	    if(CHKDKT1.checked==false)
		    {
		    for(i=0;i<ij;i++)
		    {
			    document.getElementById("ctl00_MyCPH1_CHKBOXLIST1_"+i).checked = false;
		    }
		    
	    }
	}
	 function CHKDKT2(val)
	{
	    ij="<%=CHKBOXLIST2.Items.Count%>"
	    
	     var CHKDKT2=document.getElementById("ctl00_MyCPH1_CHKDKT2");
	   
	    if(CHKDKT2.checked==true)
		{		
		    for(i=0;i<ij;i++)
		    {
	    document.getElementById("ctl00_MyCPH1_CHKBOXLIST2_"+i).checked = true;			   
		    }
	    }
	    if(CHKDKT2.checked==false)
		    {
		    for(i=0;i<ij;i++)
		    {
			    document.getElementById("ctl00_MyCPH1_CHKBOXLIST2_"+i).checked = false;
		    }
		    
	    }
	}
      
        
    </script>

    <div align="left">
        <%--<asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>--%>
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Invoice/Collection Register </strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                      <PRBAR:PRB ID="PB" runat="server" />
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Invoice/Collection Criteria</b></font>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Documnet" runat="server"></asp:Label></td>
                            <td align="left" colspan="3" valign="top">
                           <%-- OnClick="Javascript:return SelectPartyCode()"--%>
                                <asp:RadioButtonList ID="documet_type" AutoPostBack="true" runat="server"
                                 OnSelectedIndexChanged="BILL_MR_CHANGE" RepeatDirection="horizontal"
                                    CssClass="blackfnt" >
                                    <asp:ListItem Text="Bill" Selected="true" Value="B"></asp:ListItem>
                                    <asp:ListItem  Text="MR" Value="M"></asp:ListItem>   
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="Tr2" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="loctypdet" runat="server" CssClass="blackfnt">
                                        <asp:ListItem Text="Generation Location" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Sumission Location" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Collection Location" Value="3"></asp:ListItem>
                                    </asp:DropDownList></font>
                            </td>
                            <td align="left" colspan="3">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr id="Tr3" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select </font>
                                <asp:DropDownList ID="DT_TYPE" runat="server">
                                    <asp:ListItem Text="Generation Date" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Submission  Date" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Collection Date" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Cancellation Date" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left" colspan="4">
                                <font class="bluefnt"><i><b>Filters : -</b></i></font> <a href="Javascript:ShowDKTFilter();">
                                    <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideDKTFilter();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a>
                            </td>
                        </tr>
                        <tr id="TR_BILL1" runat="server" style="background-color: white">
                            <td align="left" width="300">
                                <font class="blackfnt">Select Bill Type</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="Bill_Type" AutoPostBack="true" runat="server" DataSourceID="MySQLDataSource_GeneralMaster"
                                    DataTextField="CodeDesc" DataValueField="CodeID"
                                    >
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TR_BILL2" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Bill Status</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="BILL_Status" runat="server">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Submitted- Due" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Submitted � Not Due" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Submitted- All" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Unsubmitted - All " Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Unsubmitted � Due" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Unsubmitted � Not Due" Value="6"></asp:ListItem>                                   
                                    <asp:ListItem Text="Collected" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="Not-Collected" Value="8"></asp:ListItem>
                                     <asp:ListItem Text="Cancelled" Value="9"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TR_BILL3" runat="server" style="background-color: white">
                            <td align="left" width="300">
                                <font class="blackfnt">Select BIll List Type</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="Bill_List_Type" runat="server">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="With Service Tax + Cess + H.Cess" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="W/O Service Tax + Cess + H.Cess" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                      
                        <tr id="TR_BM3" runat="server" style="background-color: white">
                            <td align="left" width="300">
                                <font class="blackfnt">Select
                                    <%=Session["DocketCalledAs"]%>
                                    Status</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="DKT_STATS" runat="server">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Delivered" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Yet Not Delivered" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TR_MR2" runat="server" style="background-color: white">
                            <td align="left" width="300">
                                <font class="blackfnt">Select MR Status</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="MR_Status" runat="server">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Closed" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Generated" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Cancelled" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TR_BM4" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Cash/Cheque</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="Bill_CL_Type" runat="server">
                                    <asp:ListItem Text="--All--" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                                    <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                                         <asp:ListItem Text="Bank" Value="Bank"></asp:ListItem>
                                    <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TR_BILL4" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Over Due Days :</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox runat="server" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                    ID="Days" Width="100" MaxLength="10"> </asp:TextBox>
                            </td>
                        </tr>
                        <tr id="TR_BM1" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Amount Greater Than :</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox runat="server" Text="0.00" onkeypress="validFloat(event,this.getAttribute('id'))"
                                    ID="BillAMT" Width="100" MaxLength="10"> </asp:TextBox>
                            </td>
                        </tr>
                        <tr id="TR_BM2" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="Left" colspan="3">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="260"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="TR_BM5" runat="server" style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>
                        <tr id="TR_BM6" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">BILL No.</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox runat="server" Text="" ID="txtbillno" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                         <tr id="TR_BM9" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">MR No.</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox runat="server" Text="" ID="txtMRNOLIST" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[Single MR for Serach Bill from MR no.]</font>
                            </td>
                        </tr>
                        <%--    <tr id="Tr17" runat="server" style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>--%>
                        <tr id="TR_BM7" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Manual BILL No.</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox runat="server" Text="" ID="txtMAnbillno" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <%--    <tr id="Tr18" runat="server" style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>
                        </tr>--%>
                        <tr id="TR_BM8" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">
                                    <%=Session["DocketCalledAs"]%>
                                    No.</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox runat="server" Text="" ID="txtDKTno" Width="280"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="Tr18" runat="server" style="background-color: white">
                            <td align="center" colspan="4">
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left" colspan="4">
                                <font class="bluefnt"><i><b>Columns : -</b></i></font> <a href="Javascript:ShowDKTColumns();">
                                    <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideDKTColumns();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a>
                            </td>
                        </tr>
                        <tr id="TR_BILLCL1" runat="server" style="background-color: white">
                            <td align="Left" colspan="2">
                            </td>
                            <td align="Left" colspan="2">
                                <asp:CheckBox Text="Select All   " CssClass="bluefnt"
                                    Font-Bold="true" TextAlign="Right" ID="CHKDKT1" onClick="CHKDKT1(this.value);"
                                    runat="server" />
                            </td>
                        </tr>
                        <tr id="TR_BILLCL2" runat="server" style="background-color: white">
                            <td align="left" colspan="4">
                                <asp:CheckBoxList ID="CHKBOXLIST1" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                    RepeatColumns="4" TextAlign="right" Width="750px" CellPadding="4" CellSpacing="0"
                                    DataSourceID="MySQLDataSource_CLLIST_ALL_BILL" DataTextField="CodeDEsc" DataValueField="CODEID">
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                     <tr id="TR_BILLCL3" runat="server" style="background-color: white">
                            <td align="Left" colspan="2">
                            </td>
                            <td align="Left" colspan="2">
                                <asp:CheckBox Text="Select All  Bill Charges Fileds " CssClass="bluefnt" Font-Bold="true"
                                    TextAlign="Right" ID="CHKDKT2" onClick="CHKDKT2(this.value);" runat="server" />
                            </td>
                        </tr>
                        <tr id="TR_BILLCL4" runat="server" style="background-color: white">
                            <td align="Left" colspan="4">
                                <asp:CheckBoxList ID="CHKBOXLIST2" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                    RepeatColumns="4" TextAlign="right" Width="750px" CellPadding="4" CellSpacing="0"
                                    DataSourceID="MySQLDataSource_BILLCHARGES" DataTextField="chargename" DataValueField="chargecode">
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        
                    </table>
                    <tr align="center" bgcolor="white">
                        <td colspan="4">
                            <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                runat="server" Text="Show" Width="75px" />
                        </td>
                    </tr>
        </table>
       <%--</ContentTemplate>
       </asp:UpdatePanel>--%>
    </div>
     <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
