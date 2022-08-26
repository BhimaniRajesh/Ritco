
<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="billmr_step2.aspx.cs" Inherits="Finance_Billing_Billcollection_billmr_step2"   %>
<%@ Register  TagPrefix="collectiondetail" TagName="chqdetail" 	Src="~/Usercontrol/WebUserControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
--%>    <script language="javascript" type="text/javascript">
   var  total_row="<%=totdkt%>"
   var totaltds=0 
      var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	var total_pendamt=0;
	cal.showNavigationDropdowns();
 function fcalbillamt(tds,frtrebate,claim,unexpamt,txtpendamt,billamt,totdkt,totalamt,netamt,obj)
{
	//alert("hi")
	
	
	//totdkt=parseInt(totdkt.value)
	//alert(tds.name)
	//billamt.value=frtamt.value;
	//billamt=parseFloat(frtamt.value)
	//alert(billamt)
    var vartotalamt=0
	var vartottds=0
//	if (totdkt==1)
//	{
        
		var  vartds=parseFloat(tds.value)
		
		var  varfrtrebate=parseFloat(frtrebate.value)
		var  varclaim=parseFloat(claim.value)
		var  varunexpamt=parseFloat(unexpamt.value)
		//alert(txtpendamt.name)
		var  varbillamt=parseFloat(txtpendamt.value)-(vartds+varfrtrebate+varclaim+varunexpamt)
		//alert(varbillamt)
		var  vartotalamt=parseFloat(vartotalamt)+varbillamt//tds+frtrebate+claim+unexpamt
		var varbillamt
		if (varbillamt<0)
		{	
			alert("Net Received amount cannot be zero")
			obj.value=0
			obj.focus()
			return false;
		}
		tottds=vartds
		//totalamt=billamt+oda+esc+undl+poddel
		totalamt.value=varbillamt
//	}
//	else
//	{
//		for (i=0;i<totdkt;i++)
//		{
//			
//		tds=parseFloat(tds[i].value)
//			frtrebate=parseFloat(frtrebate[i].value)
//			claim=parseFloat(claim[i].value)
//			unexpamt=parseFloat(unexpamt[i].value)
//			billamt=parseFloat(pendamt[i].value)-(tds+frtrebate+claim+unexpamt)
//			totalamt=parseFloat(totalamt)+billamt //tds+frtrebate+claim+unexpamt
//		
//			if (billamt<0)
//			{	
//				alert("Net Received amount cannot be zero")
//				//tds[i].focus()
//				return false;
//			}
//			tottds=tottds+tds
//			//totalamt=billamt+oda+esc+undl+poddel
//			totalamt[i].value=roundit(billamt)
//		}
//		
		
//	}
	//alert(billamt)
	if (parseFloat(totalamt.value)<0)
		totalamt.value=0
		
		//dockdata$ctl03$totalamt
		var nettotalamt=0;
		
		for (i=0;i<totdkt;i++)
		{
		     j = i + 2;
		      if(i < 10)
                {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$totalamt"
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + j + "$totalamt"
                }
                 if(i < 10)
                {
                    mDerivedControlName_tds = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$tds"
                }
                else
                {
                    mDerivedControlName_tds = "ctl00$MyCPH1$dockdata$ctl" + j + "$tds"
                }
                if(i < 10)
                {
                    mDerivedControlName_pendamt = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$txtpendamt"
                }
                else
                {
                    mDerivedControlName_pendamt = "ctl00$MyCPH1$dockdata$ctl" + j + "$txtpendamt"
                }
                if(document.getElementById(mDerivedControlName))
                {
                   // alert(document.getElementById(mDerivedControlName_tds).value)
                    nettotalamt=Math.round(parseFloat(nettotalamt)+parseFloat(document.getElementById(mDerivedControlName).value))
                    vartottds=Math.round(parseFloat(vartottds)+parseFloat(document.getElementById(mDerivedControlName_tds).value))
                    total_pendamt=Math.round(parseFloat(total_pendamt)+parseFloat(document.getElementById(mDerivedControlName_pendamt).value))
                }
                totaltds=Math.round(vartottds)
                
                //alert(totaltds)
		    netamt.value=Math.round(nettotalamt)
		}
	//netamt.value=roundit(totalamt)
	//colamt.value=roundit(totalamt)
	
	return true;
	//return true;
	//billamt.value=roundit(billamt)
	//method="post";
	//action="AreaBillGenerate_confirm.asp";
    //submit();
}
function ClearDockets(txtchqno,txtchqdt,txtindchqamt,txtonacctamt,txtonacct,txtindclamt,cbopaytype,colamt,txtbanknm,txtbankbrn,tottds,tdsacccode,netamt)
{
							paytype=cbopaytype.options[cbopaytype.selectedIndex].value;
							//alert(paytype)
							totclamt=0;
							totchqamt=0;
							
							if ((paytype=="Cheque") || (paytype=="DD"))
							{
									
								for(i=0;i<3;i++)
								{
																chqno=txtchqno[i].value
																//	alert(chqno)
																if ((chqno=="") &&(i==0))
																{
																	alert("Please enter Cheque/DD No")
																	txtchqno[i].focus();
																	return false;
																}
																if(isNaN(chqno)&&(i==0))
																{
																	alert("Cheque/DD No Should be Numeric,cannot contain characters!!! ")
																	txtchqno[i].focus();
																	return false;
																}
									
																if(chqno!="")
																{
																	//check for valid cheque date
																			
																			if(txtchqdt[i].value=="")
																			{
																				alert("Please enter cheque date")
																				txtchqdt[i].focus()
																				return false;
																			}
//																			if(txtchqdt[i].value!="")
//																			{
//																				if (ValidateForm(txtchqdt[i])==false)
//																				{
//																					 return false;
//																				}
//																			}
																				
																			
																			chqamt=txtindchqamt[i].value
																			if (isNaN(chqamt))
																			{
																					alert("Please enter proper Cheque amount")
																					txtindchqamt[i].focus();
																					return false;
																			}
																			
																			
																			clamt =	txtindclamt[i].value
																			if (isNaN(clamt))
																			{
																					alert("Please enter proper Collection amount")
																					txtindclamt[i].focus();
																					return false;
																			}
																			onacctamt=txtonacctamt[i].value
																			if(onacctamt!="")
																			{
																				if(parseFloat(onacctamt)<parseFloat(clamt))
																				{
																					alert("Accounted amount should be less than or equal to on account balance amount")
																					txtindclamt[i].focus();
																					return false;
																				}	
																			}
																			if((parseFloat(clamt)>parseFloat(chqamt))&&(parseFloat(chqamt)!=0))
																			{
																					alert("Amount Collected Against Bill should be less than or equal to Cheque Amount")
																					txtindclamt[i].focus();
																 					return false;
																			}
																			totclamt=totclamt + parseFloat(clamt);
																			totchqamt=totchqamt + parseFloat(chqamt);
																}
																else
																{
																	
																			if(txtchqdt[i].value!="")
																			{
																				if(txtchqdt[i].value!="")
																				{
																					if (ValidateForm(txtchqdt[i])==false)
																					{
																						 return false;
																					}
																				}
																			}	
																			chqamt=txtindchqamt[i].value
																			if (isNaN(chqamt) && chqamt !="")
																			{
																								alert("Please enter proper Cheque amount")
																								txtindchqamt[i].focus();
																								return false;
																			}
 																			clamt =	txtindclamt[i].value
	 																		if (isNaN(clamt) && clamt !="")
		 																	{
			    																	alert("Please enter proper Collection amount")
							    													txtindclamt[i].focus();
																				    return false;
																			 }
																}
								}
								for(i=0;i<3;i++)
								{
									currchqno=txtchqno[i].value
									currchqdt=txtchqdt[i].value
									for(j=i+1;j<3&&i!=j;j++)
									{
										chqno=txtchqno[j].value
										chqdt=txtchqdt[j].value
										if(chqno!="")
										{
											if((chqno==currchqno)&&(chqdt==currchqdt)) 
											{
												alert("Duplicate cheque Found")
							    				txtchqno[j].focus();
												return false;
											}
										}	
									}
								}
								colamt.value=parseFloat(totclamt)
								//colamt.value=roundit(parseFloat(totclamt),2)
								//txtclamt.value=roundit(parseFloat(totclamt),2)
					}
				//	return true;
	
	/*txtbillcolbrcd=txtbillcolbrcd.value
	if (txtbillcolbrcd=="") 
	{
		alert("Please enter Collection Branch!!!")
		txtbillcolbrcd.focus()
		return; 
	}*/
	
	/*cbopaytype=cbopaytype.value
	if(cbopaytype=="Cash")
	{
		chqno.value=""
		chqdate.value=""
		bankname.value=""
	} 
	else
	{
		if(chqno.value=="")
		{
			alert("Please enter Cheque No/DD No ")
			chqno.focus();
			return;
		}
		if(chqdate.value=="")
		{
			alert("Please enter Cheque /DD Date")
			chqdate.focus();
			return;
		}
		if(chqdate.value!="")
		 {
			if (ValidateForm(chqdate)==false)
			{
				 return;
			}
		 }
	}
	if(chqamount.value=="")
	{
			alert("Please enter Collection Amount")
			chqamount.focus();
			return;
	} */
//	fclearChq()
//		alert(!fcaltotchqamt1())
//	if (!fcaltotchqamt1())

//		return false;
//		
//	if (!fcalbillamt())
//	return false
	 
	
	
	transtype=cbopaytype.value
	if(transtype=="")
	{
		alert("Please Select Mode of transaction !!! ")
		cbopaytype.focus();
		return false;
	}
	
	
	for (i=0;i<total_row;i++)
		{
		     j = i + 2;
		      if(i < 10)
                {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$totalamt"
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$dockdata$ctl" + j + "$totalamt"
                }
                 if(i < 10)
                {
                    mDerivedControlName_tds = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$tds"
                    mDerivedControlName_Claim = "ctl00$MyCPH1$dockdata$ctl" + "0" + j + "$Claim"
                }
                else
                {
                    mDerivedControlName_tds = "ctl00$MyCPH1$dockdata$ctl" + j + "$tds"
                    mDerivedControlName_Claim = "ctl00$MyCPH1$dockdata$ctl" + j + "$Claim"
                }
                
                
                if(document.getElementById(mDerivedControlName))
                {
                   // alert(document.getElementById(mDerivedControlName_tds).value)
                   document.getElementById(mDerivedControlName).disabled=false
                    document.getElementById(mDerivedControlName_Claim).disabled=false
                }
                
		}
	/*if(acccode.value=="")
	{
		alert("Please Select Cash / Bank Account !!! ")
		acccode.focus();
		return;
	}*/
		 
	//alert(vartottds)
	if ((totaltds>0))
	{
			if(tdsacccode.selectedIndex==0)
			{
				alert("Please select TDS Type!!!")
				tdsacccode.focus();
				return false;
			}
			/*tdsfor=tdsfor.value
			if (tdsfor=="")
			{
				alert("Please select TDS deducted for!!!") 
				tdsfor.focus();
				return;
			}*/	
	}
	//alert(tottds)
	tottds.value=totaltds
	
	varcolamt=parseFloat(colamt.value)
    
	
	varnetamt=parseFloat(netamt.value)
	if(varcolamt != varnetamt)
	{
		alert("collected amount should be equal to Net Amount!!!")
		colamt.focus();
		return false;
	}
	
	
//	click_count=parseFloat(click_count.value)
// 	if(click_count > 0)
//	{
//		alert("Sorry... You cannot click twice !!!")
//		return ;
//	}  
//	else
//	{
//		click_count=click_count+1
//		click_count.value=click_count
//		method="post";
//		action="BillMr_submit.asp";
//		submit(); 
//		//return true;
//	}
	//return;*/
	for(i=0;i<3;i++)
								{
											chqno=txtchqno[i].value
											txtchqno[i].disabled=false
											txtchqdt[i].disabled=false
											txtindchqamt[i].disabled=false
											txtonacctamt[i].disabled=false
											txtonacct[i].disabled=false
											txtindclamt[i].disabled=false
											txtbanknm[i].disabled=false
											txtbankbrn[i].disabled=false
								}
								netamt.disabled=false
//alert("hi") 
//return false;
	return true;
}

function check_pendamt(paymentamt,netamt)
{
    if(parseFloat(paymentamt.value)>parseFloat(netamt.value))
    {
        alert("Net Amount Should not greater than Pending Amount")
        paymentamt.focus();
        return false;
    }

}
    </script>
    
<%--</head>
<body>
    <form id="frm" runat="server">--%>
    <div>
     <table  style="width:10in" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Collection 
		   
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
    <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center" style="height: 25px"><font class="blackfnt"><b> You Selected </b></font></td>
            
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
       
        <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:90%"  align="center">
       <tr class="bgbluegrey" style="height:25px">
            <td colspan="4" align="center" style="height: 25px"><font class="blackfnt"><b>MR Number : <font class="blackfnt" color="red"> System Generated</font>     </b></font></td>
            
       </tr>
        
        
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 282px"  align="center"><font class="blackfnt">MR Generation Date</font></td>
            <td style="width: 339px">
              <asp:Label ID="lblmrsdt" runat="server" Width="313px"  CssClass="blackfnt"></asp:Label></td>
             <td style="width: 282px"  align="center"><font class="blackfnt">MR branch </font></td>
            <td style="width: 339px">
                <asp:Label ID="lblmrsbr" runat="server" Width="313px"  CssClass="blackfnt"></asp:Label></td>
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
         <td style="width: 282px"  align="center"><font class="blackfnt"> 
       Party Code and Name</font></td>
            <td style="width: 339px">
                <asp:Label ID="lblpartydetail" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
           <td style="width: 282px"  align="center"><font class="blackfnt">Party Address </font></td>
            <td style="width: 339px">
                <asp:Label ID="lblpartyAddress" runat="server" Width="313px" CssClass="blackfnt"></asp:Label></td>
         
       </tr>
        
        
       </table>
       <p>
          
       <collectiondetail:chqdetail runat="server" ID="chqdetail11" />
       </p>
       <p></p>
            <center><font class="blackfnt"><b>List of Bills : </b></font> </center>
      
    <asp:GridView align="center" ID="dockdata"  Width="90%" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="100" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"

EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged"   >
 <%--OnRowDataBound="CustomersGridView_RowDataBound"  --%>
<Columns >
 
<%--<asp:BoundField DataField="Billno" HeaderText="Bill No" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblBillno" CssClass="blackfnt" Text="Billno" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:Label  ID ="txtBillno" runat="server"   CssClass="blackfnt" Text=<%# DataBinder.Eval(Container.DataItem,"Billno") %>></asp:Label>
                  
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
<asp:BoundField DataField="bgndt" HeaderText="Bill Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<%--<asp:BoundField DataField="BILLAMT" HeaderText="Billamt" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="pendamt" HeaderText="Pending Amt" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
                <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblbillamt" CssClass="blackfnt" Text="Bill Amt." runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:Label  ID ="billamt" runat="server"   CssClass="blackfnt" Text=<%# DataBinder.Eval(Container.DataItem,"BILLAMT") %>></asp:Label>
                  
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblPendAmt" CssClass="blackfnt" Text="Pending Amt." runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:Label  ID ="pendamt" runat="server"   CssClass="blackfnt"  Text=<%# DataBinder.Eval(Container.DataItem,"pendamt") %>></asp:Label>
                              <asp:HiddenField id="txtpendamt" runat="server" Value=<%# DataBinder.Eval(Container.DataItem,"pendamt") %> />
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="TDS" CssClass="blackfnt" Text="TDS" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox   ID ="tds" runat="server" MaxLength="10" Columns="12"  Text="0"></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="frt_rate" CssClass="blackfnt" Text="Freight Rebate " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="frtrebate" MaxLength="10" Columns="12"  runat="server" Text="0"></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblClaim" CssClass="blackfnt" Text="Claim" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox     ID ="Claim" MaxLength="10" Columns="12"  runat="server" Text="0"></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblunexpamt" CssClass="blackfnt" Text="Unadjusted Amount " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="unexpamt"  MaxLength="10" Columns="12" runat="server" Text="0"></asp:TextBox>
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="lblnetamt" CssClass="blackfnt" Text="Net Recd. Amount  " runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="totalamt" MaxLength="10" Columns="12"  Enabled="False"  Text=<%# DataBinder.Eval(Container.DataItem,"pendamt") %>  runat="server"></asp:TextBox>
                            <asp:HiddenField ID="Hidden_svctax_rate" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"svctax_rate") %>/>
                           <asp:HiddenField ID="Hidden_cess_rate" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"cess_rate") %>/>
                           <asp:HiddenField ID="Hidden_H_cess_rate" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"H_cess_rate") %>/>
                            <asp:HiddenField ID="Hidden_svrcamt" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"svrcamt") %>/>
                            <asp:HiddenField ID="ptmscd" runat="server"  Value=<%# DataBinder.Eval(Container.DataItem,"ptmscd") %>/>                                                                       
                    </center>
                </ItemTemplate>
 </asp:TemplateField>



</Columns>
<RowStyle />
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>

       
        <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:90%"  align="center">
      
        
       <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 143px"  align="center"><font class="blackfnt">Total</font></td>
            <td style="width: 339px">
                <asp:TextBox ID="netamt" runat="server"  Enabled="false" Columns="10" MaxLength="10"></asp:TextBox>
               <asp:HiddenField ID="totbillamt" runat="server"  /></td>
             <asp:HiddenField ID="tottds" runat="server" />
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
         <td style="width: 143px"  align="center"><font class="blackfnt"> Remark</font></td>
            <td style="width: 339px">
                <asp:TextBox ID="remarks" runat="server" Columns="20" MaxLength="2000" TextMode="MultiLine"></asp:TextBox></td>
           
       </tr>
        
        
       </table>

<p></p>
<center><asp:Button ID="submit" runat="server" Text="submit" OnClick="submit_Click1" /></center>
     </td>
        </tr>
       </table>
       </div>
       <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
      
       
       </asp:Content>
       
    <%--</form>
</body>
</html>--%>
