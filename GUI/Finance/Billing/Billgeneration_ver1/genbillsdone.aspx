
<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="genbillsdone.aspx.cs" Inherits="Finance_Billing_Billgeneration_genbillsdone"   %>
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
		function Onblurbilldate(bgndt)
		{
				//alert(FinYear_fromdate)
			///	alert(FinYear_todate)
				var dt =bgndt.value
				
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
				
				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						bgndt.focus();
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
			    //if (dt>Todate1 || dt<Fromdate1)
			    //alert(dt)
			   // alert(Fromdate1)
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  Selected Date Range "+ Fromdate +" to "+ Todate +" !!!")
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						bgndt.focus();
						return false;
				}
				return false;
				//alert("DOne")
				
		}
		
		 function total_display()
        {
         var mTotalRecords = "<%=intTotalRecords %>";
            totalamount=0
             //alert("Hi..1")
            for (var i=0;i<mTotalRecords;i++)
            {
            
                j=i+2
                if (j<10)
                {
                 frmname = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_";
                }
                else
                {
                frmname = "ctl00_MyCPH1_dockdata_ctl" + j + "_";
                }
             //   alert("Hi..1")
              totalamount=parseFloat(document.getElementById(frmname+"dktamt").innerText)+parseFloat(totalamount)
             
            }
         k=j+1  
             //  alert(k)
             //  alert(totalamount)
                if (k<10)
                {
                 frmname1 = "ctl00_MyCPH1_dockdata_ctl" + "0" + k + "_";
                }
                else
                {
                frmname1 = "ctl00_MyCPH1_dockdata_ctl" + k + "_";
                }
                // alert("Hi..2")
                document.getElementById(frmname1+"dktamt_final").innerText=rounditn(Math.round(totalamount),2)
        }
        function CheckDocketSelection(bgndt,bduedt,txtbillsubbrcd,txtbillcolbrcd,txtdocketlist,txtdocketlist_count,Manualbillno)
        {
            //Get count of records fetched
            var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
	        var MIn_dt="31/03/2008"
             //   alert("hi...1")
				if(bgndt.value=="")
				{
				  alert("Please enter the Bill Date")
				  bgndt.focus();
				  return false;
				}

				var dt =bgndt.value
				 var hdndockdt;
			   var Maxdt="01/01/2007";
			   
			    var mTotalRecords = "<%=intTotalRecords %>";
			  
                for (var i=0; i < mTotalRecords; i++)
                 {
                    // alert("1")
                    j = i + 2;
                    if(j < 10)
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_hdndt";
                      //  alert(hdndockdt)
                        hdndockdt = document.getElementById(hdndockdt).value;
                      //  alert(hdndockdt)
                        checkyn = document.getElementById("ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_chkOrderNo").checked;
                    }
                    else
                    {
                        hdndockdt = "ctl00_MyCPH1_dockdata_ctl" + j + "_hdndt";
                        hdndockdt = document.getElementById(hdndockdt).value;
                        checkyn = document.getElementById("ctl00_MyCPH1_dockdata_ctl" + j + "_chkOrderNo").checked;
                    }
                 //   alert(hdndockdt)
                   // debugger
                  
                   if(checkyn==true)
                   {
                     var Maxdt1 =Maxdt
    				
				     var Maxdt_dd=Maxdt1.substring(0,2)
				     var Maxdt_mm=Maxdt1.substring(3,5)
				     var Maxdt_yy=Maxdt1.substring(6,10)
                        
		             var hdndockdt1 =hdndockdt
				     var hdndockdt_dd=hdndockdt1.substring(0,2)
				     var hdndockdt_mm=hdndockdt1.substring(3,5)
				     var hdndockdt_yy=hdndockdt1.substring(6,10)
				    
				     Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		             hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))

				//alert(hdndockdt1)
				//alert(Maxdt1)
                    if (hdndockdt1>Maxdt1)
                    {
                    Maxdt1=hdndockdt1
                    Maxdt=hdndockdt
                    }
                  }
                }
                //  alert("hi...2")
                var dt =bgndt.value
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)

		        var sdt =server_dt
				var sdt_dd=sdt.substring(0,2)
				var sdt_mm=sdt.substring(3,5)
				var sdt_yy=sdt.substring(6,10)
				
				
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		        server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
//			alert("server_dt : " + server_dt)
//			alert("dt : " + dt)

				var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2);
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5);
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10);
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2);
				var FinYear_todate_mm=FinYear_todate.substring(3,5);
				var FinYear_todate_yy=FinYear_todate.substring(6,10);
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			 // alert("hi...3")
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Billdate Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						bgndt.focus();
						return false;
				}
				
				var Fromdate_dd=Fromdate.substring(0,2);
				var Fromdate_mm=Fromdate.substring(3,5);
				var Fromdate_yy=Fromdate.substring(6,10);
				Fromdate1=new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))
				
				var Todate_dd=Todate.substring(0,2);
				var Todate_mm=Todate.substring(3,5);
				var Todate_yy=Todate.substring(6,10);
				Todate1=new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
			
			    var MIn_dt1 =MIn_dt;
				var MIn_dt_dd=MIn_dt1.substring(0,2);
				var MIn_dt_mm=MIn_dt1.substring(3,5);
				var MIn_dt_yy=MIn_dt1.substring(6,10);
				MIn_dt1=new Date(months[parseFloat(MIn_dt_mm)] + " " + parseFloat(MIn_dt_dd) + ", " + parseFloat(MIn_dt_yy));
				 Fromdate1=Maxdt1
			     Fromdate=Maxdt
			   //  alert(dt)
			  //   alert(Fromdate)
				if (dt<Fromdate1)
				{
						//alert( "Bill Generation Date Should Be Between  "+ Fromdate +" to "+ Todate +" !!!");
						alert( "Bill Generation Date Should Be Greater than "+ Fromdate +" !!!")
						bgndt.focus();
						return false;
				}
		
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!");
						bgndt.focus();
						return false;
				}
		        if("<%=Session["Client"].ToString()%>"=="RCPL")
		        {
		            if (dt>MIn_dt1)
				    {
						    alert( "Bill date should  be less than 31 Mar 08 !!!");
						    bgndt.focus();
						    return false;
				    }
				}
				if(bduedt.value=="")
				{
						alert("Please enter the Bill Due Date");
						bduedt.focus();
						return false;
				}
			
				var bduedt1 =bduedt.value;
				var dt_dd=bduedt1.substring(0,2);
				var dt_mm=bduedt1.substring(3,5);
				var dt_yy=bduedt1.substring(6,10);
		
		        
		        
				if (dt>bduedt1)
				{
						alert( "Bill Due date should be greater than Bill date !!!");
						bduedt.focus();
						return false ;
				}	
				billcolbrcd=txtbillcolbrcd.value;
				billsubbrcd=txtbillsubbrcd.value;
				
				if(billsubbrcd=="")
				{
					alert("Please enter Submission Branch");
					txtbillsubbrcd.focus();
					return false;
				} 

				if(billcolbrcd=="")
				{
					alert("Please enter Collection Branch");
					txtbillcolbrcd.focus();
					return false;
				} 

				
				if(client_name=="RCI")
				{
					varManualbillno=Manualbillno.value;
					if(varManualbillno=="")
					{
						alert("Please enter Manual Billno");
						Manualbillno.focus();
						return false;
					} 
				}
            var mTotalRecords = "<%=intTotalRecords %>";
            //Get the selected control Name
            //Normally, ID and Name values are same
            //var mSelectedControlName = objBranch.name;
            //Will store dynamically generated control name
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
               //   alert("hi...4")
            //Loop through the records
            for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
                if(j < 10)
                {
                    mDerivedControlName = "ctl00_MyCPH1_dockdata_ctl" + "0" + j + "_chkOrderNo";
                }
                else
                {
                    mDerivedControlName = "ctl00_MyCPH1_dockdata_ctl" + j + "_chkOrderNo";
                }
               
                //Populate Docket No.s for Preaparing Loading Sheet
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    { 
                        if(mSelection == 0)
                        {
                            mSelection = 1;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one docket to prepare Bill!");
                return false;
            }
            txtdocketlist_count.value=mSelection
            txtdocketlist.value=mSelectedDockets;
           //alert("hi-" +  txtdocketlist.value)
            
         click_count=parseFloat(document.getElementById("ctl00$MyCPH1$click_count").value)
               // alert(click_count)
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00$MyCPH1$click_count").value=click_count
					return true;
				}  
        }
          function rounditn(Num,decplaces)
	{
		Places=decplaces
		if (Places > 0) 
			{
			
			if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
			{
			
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				var Rounder = Math.pow(10, Places);
				return Math.round(Num * Rounder) / Rounder;
			}
			else 
			{
				//alert("Hi")
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				else
				{  
					if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
						return Num.toString() +'0';	
					else
						return Num.toString();				   

				}
			}
			}
		else return Math.round(Num);
		
	}
    </script>
        
<%--</head>

<body>
    <form id="form1" method="post"  runat="server">--%>
    <div>
    <table style="width:10in"border="0" cellpadding="0" cellspacing="0">
    <asp:HiddenField ID="click_count" runat="server" Value="0"  />
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Generation
		   
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
          <td > <center><font class="blackfnt"><b>Select Bills for Submission </b></font> </center></td></tr>
   <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    <tr>
    <td>
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center" style="height: 25px"><font class="blackfnt"><b> Bill </b></font></td>
            
       </tr>
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px"  align="center"><font class="blackfnt">Customer Code and Name</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblparty" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
         <td style="width: 282px; height: 25px;"  align="center"><font class="blackfnt">Docket 
        Booking Date Range </font></td>
            <td style="width: 339px; height: 25px;">
                <asp:Label ID="lbldaterange" runat="server" Text="Label" Width="313px" CssClass="blackfnt"></asp:Label></td>
           
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
        <td style="width: 282px"  align="center"><font class="blackfnt">Pay Basis</font>
            </td>
            <td style="width: 339px">
                <asp:Label ID="lblpaybas" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px"  align="center"><font class="blackfnt">Mode Of Transport</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblmod" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;" runat="server" id="Tr_but"  visible="false">
            <td style="width: 282px"  align="center"><font class="blackfnt">Business Type</font></td>
            <td style="width: 339px">
                <asp:Label ID="Lblbut" runat="server" Text="Label" Width="313px"  CssClass="blackfnt"></asp:Label></td>
       </tr>
       </table>
        <br />
        <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="font-size: 12pt;
            width: 80%; font-family: Times New Roman">
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 148px">
                    <font class="blackfnt">Bill Number</font>
                </td>
                <td style="font-size: 12pt; width: 195px; font-family: Times New Roman">
                    <font class="blackfnt" color="red">System Generated...</font></td>
                <td style="font-size: 12pt; width: 203px; font-family: Times New Roman">
                    <span style="font-size: 8pt; font-family: Verdana">Bill Branch</span></td>
                <td style="font-size: 12pt; font-family: Times New Roman; width: 260px;"> <font class="blackfnt">  <%=Session["brcd"].ToString() %></font>
                </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; color: #000000; font-family: Times New Roman;
                height: 25px">
                <td style="width: 148px; height: 24px">
                    <span style="font-size: 8pt; font-family: Verdana">Bill Date</span>
                    
                    </td>
                <td style="height: 24px">
                    <asp:TextBox ID="txtbgndt" CssClass="blackfnt" runat="server" Columns="10" MaxLength="10"></asp:TextBox>
                   <a HREF="#"  onClick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtbgndt,'anchor112','dd/MM/yyyy'); return false;"  NAME="anchor112" ID="anchor112" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtbgndt"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtbgndt" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                               
                        </td>
                <td style="font-size: 12pt; width: 203px; font-family: Times New Roman; height: 24px">
                    <span style="font-size: 8pt; font-family: Verdana">Due Date</span></td>
                <td style="font-size: 12pt; font-family: Times New Roman; height: 24px; width: 260px;">
                    <asp:TextBox ID="txtduedate" runat="server"   CssClass="blackfnt" Columns="10" MaxLength="10"></asp:TextBox>
                     <a HREF="#"  onClick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtduedate,'anchor1','dd/MM/yyyy'); return false;"  NAME="anchor1" ID="anchor1" ><img src="../../../images/calendar.jpg" border="0" /> 
                                  </a>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtduedate"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                         <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtduedate" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                               </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; color: #000000; font-family: Times New Roman;
                height: 25px">
                <td style="width: 148px">
                    <span style="font-size: 8pt; font-family: Verdana">Bill Type</span></td>
                <td>
                    <span style="font-size: 8pt; font-family: Verdana">Freight Bill</span></td>
                <td style="font-size: 12pt; width: 203px; font-family: Times New Roman">
                    <span style="font-size: 8pt; font-family: Verdana">Party name</span></td>
                <td style="font-size: 12pt; font-family: Times New Roman; width: 260px;">
                    <asp:Label ID="LblPTMSCD" runat="server" Text="Label" Width="257px"   CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; color: #000000; font-family: Times New Roman;
                height: 25px">
                <td style="width: 148px; height: 25px">
                    <span style="font-size: 8pt; font-family: Verdana">Bill Submission at</span></td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtbillsubloc"  CssClass="blackfnt"  runat="server" Columns="4" MaxLength="4"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtbillsubloc"
                        ErrorMessage="*"></asp:RequiredFieldValidator></td>
                <td style="font-size: 12pt; width: 203px; font-family: Times New Roman; height: 25px">
                    <font class="blackfnt">Billing Party Address</font></td>
                <td style="font-size: 12pt; font-family: Times New Roman; height: 25px; width: 260px;">
                </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                <td style="width: 148px">
                    <span style="font-size: 8pt; font-family: Verdana">Bill Collection at</span></td>
                <td>
                    <font class="blackfnt">
                        <asp:TextBox ID="txtbillcolloc"   CssClass="blackfnt"  style="padding:center" runat="server" Columns="4" Rows="4"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtbillcolloc"
                            ErrorMessage="*" ></asp:RequiredFieldValidator></font></td>
                <td style="width: 203px">
                   <font class="blackfnt"> Party Phone Number</font></td>
                <td style="font-size: 12pt; font-family: Times New Roman; width: 260px;">
                </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; color: #000000; font-family: Times New Roman;
                height: 25px">
                <td style="width: 148px; height: 25px;"><font class="blackfnt">Manual Billno.</font>
                
                </td>
                <td style="height: 25px">
                    <asp:TextBox ID="txtManualbillno" runat="server" MaxLength="50" Columns="20"  onchange="javascript:this.value=this.value.toUpperCase()" CssClass="blackfnt"></asp:TextBox>
                </td>
                <td style="width: 203px; height: 25px;">
                   <font class="blackfnt"> Party E-mail</font></td>
                <td style="height: 25px; width: 260px;">
                </td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                <td style="width: 148px; height: 25px">
                    <font class="blackfnt">Remark</font></td>
                <td colspan="3" style="height: 25px">
                    <asp:TextBox ID="txtremars" runat="server" Rows="2" TextMode="MultiLine" onchange="javascript:this.value=this.value.toUpperCase()"></asp:TextBox></td>
            </tr>
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 148px; height: 25px">
                   <font class="blackfnt"> Special Instruction</font></td>
                <td colspan="3" style="height: 25px">
                    <asp:TextBox ID="txtspl_ins" runat="server" Rows="2" TextMode="MultiLine"  onchange="javascript:this.value=this.value.toUpperCase()"></asp:TextBox></td>
            </tr>
        </table>
       <br />
   <asp:DataGrid ID="dockdata"  align="center" runat="server" AutoGenerateColumns="False" Width="776px" 
                                    Style="text-align: left" CssClass="blackfnt" Visible="true" DataKeyField="dockno" ShowFooter="true" >
                                    <AlternatingItemStyle BackColor="#EEEEEE" CssClass="blackfnt"  />
                                 
                                    <HeaderStyle CssClass="bgbluegrey"  />
    <Columns>
    
    <asp:TemplateColumn  >
	<headertemplate></headertemplate>
                                        <ItemTemplate >
                                     <%-- <asp:CheckBox id="chkOrderNo"  CssClass="input" runat="server"    />--%>
                                        <input type="checkbox" id="chkOrderNo" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"dockno") %>' />
                                        </ItemTemplate>
                                       </asp:TemplateColumn>
     <asp:TemplateColumn   HeaderText="Docket NO." HeaderStyle-Wrap="false" HeaderStyle-CssClass="">
	 
                <ItemTemplate>
                    <center>
                
                    <asp:Label CssClass="blackfnt" ID="docketno"   text ='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'   runat="server" >
                    </asp:Label>
                    </center>
                </ItemTemplate>
              
     </asp:TemplateColumn>

       
 <%--<asp:BoundColumn HeaderText="Docket NO." ReadOnly="True" DataField="docknosf"/>--%>

    <asp:BoundColumn HeaderText="Paybas" ReadOnly="True" ItemStyle-Wrap="false"  DataField="paybasdesc"/>

<asp:BoundColumn HeaderText="Mode" ReadOnly="True" ItemStyle-Wrap="false"  DataField="modedesc"/>

<asp:BoundColumn HeaderText="Bkg Date : Comm Dely DT"   ItemStyle-Wrap="false" HeaderStyle-Wrap="false" ReadOnly="True" DataField="dock_cdeldt"/>
<asp:BoundColumn HeaderText="Chrg Wt./Freight" ReadOnly="True"  ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false"  DataField="FRT_chrg_RATE" />

<asp:BoundColumn HeaderText="Freight Rate(pre Kg/Pkg)" ReadOnly="True"  ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false"  DataField="FRT_RATE" />

<asp:BoundColumn HeaderText="Docket Charges" ReadOnly="True"   ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false" DataField="dktchg"/>

<asp:BoundColumn HeaderText="FOV Charges" ReadOnly="True"  HeaderStyle-Wrap="false"  ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" DataField="FOV"/>
<asp:BoundColumn HeaderText="Other Charges" ReadOnly="True"  ItemStyle-Wrap="false"   ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false" DataField="otchg"/>
<asp:BoundColumn HeaderText=" Service Tax" ReadOnly="True"   ItemStyle-Wrap="false"  ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false" DataField="SVCTAX"/>
<asp:BoundColumn HeaderText="Docket Total" ReadOnly="True"   ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="right" HeaderStyle-Wrap="false"  DataField="dkttot"/>

 <asp:TemplateColumn   HeaderText="Docket Total" HeaderStyle-Wrap="false" HeaderStyle-CssClass="">
	 <headertemplate>Docket Total </headertemplate>
	 <HeaderStyle  CssClass="blackfnt" Font-Bold="false"/>
                <ItemTemplate>
                    <center>
                
                    <asp:Label CssClass="blackfnt" ID="dktamt"   text ='<%# DataBinder.Eval(Container.DataItem,"dkttot") %>'   runat="server" >
                     
                    </asp:Label>
                    <asp:HiddenField ID="hdndt" runat="server" Value=<%# DataBinder.Eval(Container.DataItem,"dockdt") %> ></asp:HiddenField>
                    </center>
                </ItemTemplate>
                <FooterStyle CssClass="Blackfnt" />
                <FooterTemplate >
                  <center>
                
                    <asp:Label CssClass="blackfnt" ID="dktamt_final"   text ='0.00'   runat="server" >
                    </asp:Label>
                    </center>
                </FooterTemplate>
     </asp:TemplateColumn>

   
     </Columns>
       
   
    </asp:DataGrid>
     <br />
   
 

    <br />
    <br />
    
     <p></p>
       <asp:HiddenField ID="txtdocketlist" runat="server" />
       <asp:HiddenField ID="txtdocketlist_count" runat="server" />
       
       <p> <center> <asp:Button ID="Button1" runat="server"  CssClass="blackfnt" Text="Click Here to GENERATE BILL for checked Dockets"  OnClick="Button1_Click"/></center></p>
       
        </td>
        </tr>
       </table>
       
       </div>
        <script language="javascript" type="text/javascript" >
								   window.onload=total_display
        </script>
        <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV></asp:Content>
      
<%--    </form>
</body>
</html>--%>
