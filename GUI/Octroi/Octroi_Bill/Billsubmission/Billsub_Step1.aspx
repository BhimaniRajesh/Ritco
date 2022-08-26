<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="Billsub_Step1.aspx.cs" Inherits="Finance_Billing_Billsubmission_Billsub_Step1"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />--%>
    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
      <script language="javascript" type="text/javascript">
         var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
     var client_name="<%=Session["Client"]%>"
		var Fromdate="<%=Fromdate%>"
		var Todate="<%=Todate%>"
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
        function CheckDocketSelection(txtbsbdt,txtbillsubto,contactno,txtdocketlist,txtdocketlist_count)
        {
                
            	        if(txtbsbdt.value=="")
						{
							alert("Please enter Bill Submission Date!!!")
							txtbsbdt.focus();
							return false;
						}
//						if(bsbdt.value!="")
//						{
//						   if (ValidateForm(bsbdt)==false)
//						   {
//						   	 return;
//						   }
//						}
						//bill submission date should be greater than generation date
						/*var dt =bgndt.value
							//alert(dt)
						var dt_dd=dt.substring(0,2)
						var dt_mm=dt.substring(3,5)
						var dt_yy=dt.substring(6,10)
		
						bgndt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
						//alert(duedt)
		
						
		
						
						if (bgndt>bsbdt)
						{
							alert( "Bill Submission Date Should be greater than Bill Generation Date!!!")
							bsbdt.focus();
							return;
						}
		*/
						dt =txtbsbdt.value
						dt_dd=dt.substring(0,2)
						dt_mm=dt.substring(3,5)
						dt_yy=dt.substring(6,10)
						
						bsbdt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
//						currdate=txtbgndt.value
//						dt_dd=currdate.substring(0,2)
//						dt_mm=currdate.substring(3,5)
//						dt_yy=currdate.substring(6,10)
//						//alert("hi")
//						bgndt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
//						
//						//alert(currdate)
//						if (bgndt > bsbdt)
//						{
//								alert("Bill Submission Date should be greater than or equal to  Bill Generation Date " + months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy) + " \n")
//								bsbdt.focus();
//								return;
//						}
						
						currdate="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
						dt_dd=currdate.substring(0,2)
						dt_mm=currdate.substring(3,5)
						dt_yy=currdate.substring(6,10)
						//alert("hi")
						currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (bsbdt>FinYear_todate1 || bsbdt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						txtbsbdt.focus();
						return false;
				}
				var Fromdate_dd=Fromdate.substring(0,2)
				var Fromdate_mm=Fromdate.substring(3,5)
				var Fromdate_yy=Fromdate.substring(6,10)
				Fromdate1=new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))
				
				var Todate_dd=Todate.substring(0,2)
				var Todate_mm=Todate.substring(3,5)
				var Todate_yy=Todate.substring(6,10)
				Todate1=new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
			
				if (bsbdt>Todate1 || bsbdt<Fromdate1)
				{
						alert( "Bill Generation Date Should Be Between  Selected Date Range "+ Fromdate +" to "+ Todate +" !!!")
						txtbsbdt.focus();
						return false;
				}
						//alert(currdate)
						if (currdate < bsbdt)
						{
								alert("Bill Submission Date should be less than or equal to  system Date \n")
								txtbsbdt.focus();
								return false;
						}
							
						billsubto=txtbillsubto.value	
		
						if (billsubto=="")
						{
							alert("Please Enter bill Submitted To")
							txtbillsubto.focus();
							return false;
						}
            //Get count of records fetched
            var mTotalRecords = "<%=intTotalRecords %>"
            //Get the selected control Name
            //Normally, ID and Name values are same
            //var mSelectedControlName = objBranch.name;
            //Will store dynamically generated control name
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
                
            //Loop through the records
            mSelection=0
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
                if(i < 10)
                {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$chkDock"
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + j + "$chkDock"
                }
                
                //Populate Docket No.s for Preaparing Loading Sheet
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                           mSelection=1 ;
                        }
                        else
                        {
                         mSelection = mSelection + 1
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                       
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one docket to prepare loading sheet!");
                return false;
            }
            //alert(mSelection)
            txtdocketlist_count.value=mSelection
           txtdocketlist.value=mSelectedDockets;
          // alert("hi-" + txtdocketlist_count.value)
            
            return true;
        }
        
    </script>
<%--<<%--/head>
<body>
    <form id="form1" runat="server">--%>
    <div>
    <table style="width:10in" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Submission 
		   
		  </strong> </font>
   </td></tr>
     <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../../images/back.gif" border=0></a></td>
        </tr>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
   
    <tr>
    <td>
    
   
    <br />
    <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center" style="height: 25px"><font class="blackfnt"><b> Bill </b></font></td>
            
       </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td align="center" style="width: 282px">
                <font class="blackfnt">Billno</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></td>
        </tr>
        
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px"  align="center"><font class="blackfnt">Customer Code and Name</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblparty" runat="server" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
         <td style="width: 282px"  align="center"><font class="blackfnt">Docket 
        Booking Date Range </font></td>
            <td style="width: 339px">
                <asp:Label ID="lbldaterange" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
           
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
        <td style="width: 282px"  align="center"><font class="blackfnt">Pay Basis</font>
            </td>
            <td style="width: 339px">
                <asp:Label ID="lblpaybas" runat="server" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        
        
       </table>
       <p></p>
       <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr  class="bgbluegrey" style="height:25px">
            <td colspan="2" align="center" style="height: 24px"><font class="blackfnt"><b> Update Submission Details </b></font></td>
            
       </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td align="center" style="width: 282px">
                <font class="blackfnt">Enter Bill Submission Date</font></td>
            <td style="width: 339px">
                <asp:TextBox ID="txtbsbdt" runat="server" Width="55"></asp:TextBox>
                <a HREF="#"  onClick="cal.select(ctl00$MyCPH1$txtbsbdt,'anchor112','dd/MM/yyyy'); return false;"  NAME="anchor112" ID="anchor112" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Plz Enter Bill Submission Date" ControlToValidate="txtbsbdt"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtbsbdt" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                        </td>
                                        </tr>
        
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px; height: 25px;"  align="center"><font class="blackfnt">Bill Submitted to</font></td>
            <td style="width: 339px; height: 25px;">
                <asp:TextBox ID="txtsubto" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Plz Enter Bill Submission TO" ControlToValidate="txtsubto"></asp:RequiredFieldValidator></td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
         <td style="width: 282px"  align="center"><font class="blackfnt">Customer Billing Contact No. </font></td>
            <td style="width: 339px">
                <asp:TextBox ID="txtsubcontactno" runat="server"></asp:TextBox></td>
           
       </tr>
        
       </table>
        <p>
    </p>
     <center><font class="blackfnt"><b>List of Bills for which Bill Can be Submited:  </b></font> </center>
   
    <asp:GridView align="center" ID="dockdata" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged" >
<Columns >
  <asp:TemplateField>
                <ItemTemplate>
                    <center>
                      <input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"billno") %>' />
                    <%--<asp:CheckBox id="chkDock" runat="server"   />--%>
                    </center>
                </ItemTemplate>
     </asp:TemplateField>


<asp:TemplateField>
<HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                <ItemTemplate>
                
                    <center>
                    
                    <asp:Label CssClass="blackfnt"  ID="billno"   text =<%# DataBinder.Eval(Container.DataItem,"billno") %>   runat="server" >
                   </asp:Label>
                    </center>
                </ItemTemplate>
     </asp:TemplateField>




<asp:BoundField DataField="Bbrcdnm" HeaderText="Billing Branch" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="ptmsstr" HeaderText="Party Name" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="paybas" HeaderText="Bill Type" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="BILLAMT" HeaderText="Bill Amt." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="pendamt" HeaderText="Unadjusted Amount" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="BGNDT" HeaderText="Generation Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>
<asp:BoundField DataField="bduedt" HeaderText="Due Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>



</Columns>
<RowStyle />
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>
<br />
    <br />
    
     <p></p>
       
       <p> </p>
<asp:HiddenField ID="txtdocketlist" runat="server" />
       <asp:HiddenField ID="txtdocketlist_count" runat="server" />
       
    <center> <asp:Button ID="Button1" runat="server"  CssClass="blackfnt" Text="Click Here to Sumit Bills"  OnClick="Button1_Click"/></center>
</td>
        </tr>
       </table>
    </div><DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV></asp:Content>
   <%-- </form>
</body>
</html>--%>
