<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_OUTSTD_SSRS_Query"  %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="Select CodeID='All', CodeDesc='--All--'  union select codeid,codedesc from webx_master_general where codetype='BILLTYP' and statuscode='Y'"
        SelectCommandType="Text">
       
    </asp:SqlDataSource>
    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        
    window.onload=function()
	{
	 document.getElementById("ctl00_MyCPH1_RPT_SUBTYP_0").disabled=true
	 document.getElementById('ctl00_MyCPH1_TR_2').style.display = "none"; 
	  document.getElementById('ctl00_MyCPH1_TR5').style.display = "none";          
	  document.getElementById('ctl00_MyCPH1_TR4').style.display = "none";     
	  
	}
    
    	
	function checkAll()
     {
     // alert("Hii")
      var chk=null;
        var i=0;
        var chkall=document.getElementById("ctl00_MyCPH1_ChkAllPaybas");
  
        do
        {     
             chk=document.getElementById("ctl00_MyCPH1_ChkPaybas_" + i +"");            
                         
            if(chk)
            {    
            
           // alert(chk.disabled)                           
                if(chkall.checked==true)
                {
                  chk.checked=true;                         
                }
                else
                {                  
                    chk.checked=false;
                }
            }                       
            i++;
        }while(chk);        
        return true;
     }
	
    
      function ChkCust(val)
	{
	   if(document.getElementById("ctl00_MyCPH1_RPT_TYP_1").checked==true ){
	    	    document.getElementById("ctl00_MyCPH1_RPT_SUBTYP_0").disabled=true
	    	    document.getElementById("ctl00_MyCPH1_RPT_SUBTYP_1").disabled=false}
	   else 
	      {
	    	    document.getElementById("ctl00_MyCPH1_RPT_SUBTYP_0").disabled=false
	    	    document.getElementById("ctl00_MyCPH1_RPT_SUBTYP_1").disabled=true
	      }
	    
	  }
	  
	    function ShowDKTFilter() 
       {
            HideDKTFilter() ;
            
            document.getElementById('ctl00_MyCPH1_TR4').style.display = "block";          
              
        }
        
          function HideDKTFilter() 
       {
           document.getElementById('ctl00_MyCPH1_TR4').style.display = "none";          
           }
	  
	 function ChkCust_SUB(val)
	 {
	     if(document.getElementById("ctl00_MyCPH1_RPT_FORTYP_0").checked==true ||  document.getElementById("ctl00_MyCPH1_RPT_FORTYP_1").checked==true )
	     {
	     
              document.getElementById('ctl00_MyCPH1_TR_1').style.display = "block";              
               document.getElementById('ctl00_MyCPH1_TR_2').style.display = "none"; 
              document.getElementById('ctl00_MyCPH1_TR_3').style.display = "block";   
	     }
	     else  if(document.getElementById("ctl00_MyCPH1_RPT_FORTYP_2").checked==true )
	     {
                   document.getElementById('ctl00_MyCPH1_TR_1').style.display = "none"; 
                   document.getElementById('ctl00_MyCPH1_TR_2').style.display = "block"; 
                   document.getElementById('ctl00_MyCPH1_TR_3').style.display = "none";              
               
	     }
	     
	     if(document.getElementById("ctl00_MyCPH1_RPT_FORTYP_1").checked==true )
	     {
	      document.getElementById('ctl00_MyCPH1_TR5').style.display = "block";          
	     }
	     else
	     {
	      document.getElementById('ctl00_MyCPH1_TR5').style.display = "none";          
	     } 
	 }
	  
	  function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
       
       function OnSub_DATACHECK()
     {
        
     
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
       // if(!FinDateCheck())
         //   return false;             
     }
     
     
       function toBlur(idx)
    {

        var toid="",fromid="";
        if(idx<10)
        {
            fromid="ctl00_MyCPH1_grvftls_ctl0" + (parseInt(idx)+1) + "_txtfrom";
            toid="ctl00_MyCPH1_grvftls_ctl0" + idx + "_txtto";
        }
        else
        {
            fromid="ctl00_MyCPH1_grvftls_ctl" + (parseInt(idx)+1)  + "_txtfrom";
            toid="ctl00_MyCPH1_grvftls_ctl" + idx + "_txtto";
        }
        var txtto = document.getElementById(toid);
        var txtfrom = document.getElementById(fromid);
        
        if(txtfrom)
        {
            txtfrom.value=parseInt(txtto.value) + 1;
        }
    }
    </script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

    </script>

   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 22/5/2014 --%>
<div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="bluefnt"><strong>&gt; </strong><strong>Account Receivable </strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img id="Img1" src="./../../images/loading.gif" runat="server" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                    opacity: .50; -moz-opacity: .50;" runat="server">
                                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                        left: 50%;" ID="Panel2" runat="server">
                                    </asp:Panel>
                                </asp:Panel>
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
                    <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2">
                                <font class="blackfnt"><b>Select Bill Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="RPT_LOC" RepeatDirection="horizontal" CssClass="blackfnt" runat="server">
                                        <asp:ListItem Text="Generation Location" Selected="true" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Submission Location" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Collection Location" Value="3"></asp:ListItem>
                                    </asp:DropDownList></font></td>
                            <td align="left">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                          <tr id="dkttr1" runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <font class="blackfnt">Select Paybas</font>
                                <%--<asp:CheckBox ID="ChkAllPaybas" runat="server" Onclick="Javascript:return checkAll();" Text="All" />--%>
                            </td>
                            <td align="left">
                           <asp:DropDownList 
                                  runat="server" ID="ChkPaybas" DataSourceID="MySQLDataSource_GeneralMaster"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                                <%--<asp:CheckBoxList RepeatDirection="Horizontal" 
                                  runat="server" ID="ChkPaybas" DataSourceID="MySQLDataSource_GeneralMaster"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:CheckBoxList>--%>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
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
                        
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Reprot Type " runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="RPT_TYP" RepeatDirection="horizontal" CssClass="blackfnt"
                                    onClick="javascript:ChkCust(this);" runat="server">
                                    <asp:ListItem Text="Location Wise" Selected="True" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise " Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Reprot Type " runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="RPT_SUBTYP" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="Location Wise" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise " Value="2"></asp:ListItem>
                                    <asp:ListItem Text="none" Selected="True" Value="0"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label5" CssClass="blackfnt" Text="Select Reprot Type " runat="server"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="RPT_FORTYP" RepeatDirection="horizontal" CssClass="blackfnt"
                                    onClick="javascript:ChkCust_SUB(this);" runat="server">
                                    <asp:ListItem Text="Status Wise" Selected="True" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Age Wise " Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Specific Date Range Wise " Value="3"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="TR_3" runat="server" style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="RPT_DATE" RepeatDirection="horizontal" CssClass="blackfnt"
                                        runat="server">
                                        <asp:ListItem Text="Generation Date" Selected="true" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Submission Date" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Collection Date" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="TR_2" runat="server" align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">Select
                                    <asp:DropDownList ID="RPT_DATE_1" RepeatDirection="horizontal" CssClass="blackfnt"
                                        runat="server">
                                        <asp:ListItem Text="Generation Date" Selected="true" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Submission Date" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Collection Date" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                </font><font class="blackfnt">As On Date</font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtasondt" Width="60" MaxLength="10" runat="server"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt,'anchor3','dd/MM/yyyy'); return false;"
                                    name="anchor3" id="a3">
                                    <img src="./../../images/calendar.jpg" id="i1" runat="server" border="0" />
                                </a>
                                <asp:Label ID="Label3" CssClass="blackfnt" runat="server" Text=" To"></asp:Label>
                                <asp:TextBox ID="txtasondt_to" Width="60"  MaxLength="10" runat="server"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt_to,'anchor45','dd/MM/yyyy'); return false;"
                                    name="anchor45" id="a45">
                                    <img src="./../../images/calendar.jpg" id="i2" runat="server" border="0" />
                                </a>
                            </td>
                        </tr>
                        <tr id="TR_1" runat="server" align="center" bgcolor="white">
                            <td align="left">
                                <font class="blackfnt">As On Date</font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtasondt_1" Width="60" MaxLength="10" runat="server"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt_1,'anchor4','dd/MM/yyyy'); return false;"
                                    name="anchor4" id="a1">
                                    <img src="./../../images/calendar.jpg" id="Img2" runat="server" border="0" />
                                </a>
                            </td>
                        </tr>
                        <tr id="TR5" runat="server" align="center" bgcolor="white">
                            <td colspan="2" align="left">
                                <font class="bluefnt"><i><b>Aging : -</b></i></font> <a href="Javascript:ShowDKTFilter();">
                                    <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideDKTFilter();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a>
                            </td>
                        </tr>
                        <tr id="TR4" runat="server" align="center" bgcolor="white">
                            <td colspan="2" align="left">
                                <asp:UpdatePanel ID="updone" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtnorows" runat="server" Width="40px" MaxLength="3" Style="text-align: right;"
                                            onkeypress="javascript:return validInt(event)" BorderStyle="Groove"></asp:TextBox>
                                        <asp:Button ID="btnnorows" runat="server" CssClass="blackfnt" Text="Add Rows" OnClick="btnnorows_Click" />
                                        <font class="blackfnt">(Max Row Size : - 10)</font>
                                        <br />
                                        <br />
                                        <asp:GridView HorizontalAlign="Left" ID="grvftls" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                            HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgbluegrey" PagerSettings-Mode="NumericFirstLast"
                                            ShowFooter="true" ShowHeader="true" AutoGenerateColumns="false" OnRowDataBound="grvftls_RowDataBound"
                                            EmptyDataText="No Records Found..." Style="width: 30%;">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Age From " HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtfrom" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                                            Width="70px" Text='<%# DataBinder.Eval(Container.DataItem,"from") %>' CssClass="blackfnt"
                                                        ReadOnly="true"     onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
                                                        </asp:TextBox>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txtfrom" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                                            Width="70px" Text='<%# DataBinder.Eval(Container.DataItem,"from") %>' CssClass="blackfnt" Font-Bold="true"
                                                            ReadOnly="true" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
                                                        </asp:TextBox>
                                                    </FooterTemplate>
                                                    <HeaderTemplate>
                                                       <asp:Label ID="lbl1"  Text="From" CssClass="balcfnt" runat="server" ></asp:Label> 
                                                       <asp:TextBox ID="txtfrom" runat="server" BorderStyle="Groove" Text="UnDue" Font-Bold="true" Style="text-align: right;"
                                                            Width="70px"  CssClass="blackfnt"
                                                            ReadOnly="true" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
                                                        </asp:TextBox>
                                                    </HeaderTemplate>
                                                    <FooterStyle BackColor="White" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Age To" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtto" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                                            Width="70px" Text='<%# DataBinder.Eval(Container.DataItem,"to") %>' CssClass="blackfnt"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
                                                        </asp:TextBox>
                                                    </ItemTemplate>
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txtto" runat="server" BorderStyle="Groove" Style="text-align: right;" Font-Bold="true"
                                                            Width="70px"  Text="365" CssClass="blackfnt"
                                                            ReadOnly="true" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
                                                        </asp:TextBox>
                                                    </FooterTemplate>
                                                    
                                                    <HeaderTemplate>
                                                       <asp:Label ID="lbl2" CssClass="balcfnt " Text="To"  runat="server" ></asp:Label>  <asp:TextBox ID="txtto" runat="server" Text="UnDue" Font-Bold="true" BorderStyle="Groove" Style="text-align: right;"
                                                            Width="70px"  CssClass="blackfnt"
                                                            ReadOnly="true" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))">
                                                        </asp:TextBox>
                                                    </HeaderTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                    runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return DateCheck();"--%>
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
