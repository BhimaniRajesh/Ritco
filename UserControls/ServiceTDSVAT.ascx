<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ServiceTDSVAT.ascx.cs" Inherits="UserControls_ServiceTDSVAT" %>

 <script language="javascript" type="text/javascript">


function Nagative_Chk_wDecimal(obj)
{
	var temp
	temp=obj.value 
	//alert(temp)					
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
        obj.value="0.0";
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value="0.0";
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value="0.0";
		obj.focus();
		return false;
	}
	obj.value=roundit(temp) 
	return true;					   
}


//--------TDS : 3 DECIMAL PALCES --------------------
function Nagative_Chk_wDecimalTDS(obj)
{
	var temp
	temp=obj.value 
	//alert(temp)					
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
        obj.value="0.0";
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value="0.0";
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value="0.0";
		obj.focus();
		return false;
	}
	obj.value=rounditn(temp,3) 
	return true;					   
}

//----------------------------------------


function roundit(Num)
	{
		Places=2
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
     
     function GetTot()
     {
     
     }

function TABLE1_onclick() {

}

    </script>
    
    
    
    <asp:Panel ID="pnlVATDetails" runat="server" Width="100%" >      
                                   
                          <table cellspacing="1" style="width: 100%" class="boxbg"  border="0">
                        <tr class="bgbluegrey">
                            <td   colspan="4"  align="left" style="height: 20px">
                       
                             <font class="bluefnt"><b>VAT Details</b></font>
                        <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                            </td>
                            
                            </tr>
                               </table>
                        </asp:Panel>
    <asp:Panel ID="pnlVAT" runat="server" Width="800px" >
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="3">
                  <asp:CheckBox ID="vat_yn" runat="server" onclick="javascript:GetTotal()" /> <strong> <font  color="red">Plz Check Here to Enable VAT</font></strong>
                </td>
             </tr>
             <tr class="bgbluegrey">
                <td style="text-align: center; height: 21px;" class="blackfnt" colspan="3">
                    <strong>ADD VAT(+) </strong>
                </td>
             </tr>
             <tr style="background-color: White">
                <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;VAT Rate
                </td>
                
                 <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;VAT Amount
                </td>
             </tr> 
             <tr style="background-color: White">
                <td style="text-align: left; width: 272px;" class="blackfnt" >
                    &nbsp;<asp:TextBox ID="txtVATAppLAmt" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align: right"></asp:TextBox>
                </td>
                <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtVATRate" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="true" style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this);GetTotal()"></asp:TextBox>
                </td>
                
                 <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtVATAmt" runat="server" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" style="text-align: right"></asp:TextBox>
                </td>
             </tr>    
                     
    </table>   
    </asp:Panel>
        <ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server" 
         TargetControlID="pnlVAT"
        ExpandControlID="pnlVATDetails" CollapseControlID="pnlVATDetails" Collapsed="True"
        TextLabelID="lblTDSH" ExpandedText="Hide..." CollapsedText="Show..."
        SuppressPostBack="true"/>
    <br>  
    
  <asp:Panel ID="pnlSTAXTDSDetails" runat="server" Width="100%" >      
                                   
                          <table cellspacing="1" style="width: 100%" class="boxbg"  border="0">
                        <tr class="bgbluegrey">
                            <td   colspan="4"  align="left" style="height: 20px">
                       
                             <font class="bluefnt"><b>Service Tax & TDS Details</b></font>
                        <asp:Label ID="lblTDSHTAX" runat="server" Font-Bold="True">Show...</asp:Label>
                            </td>
                            
                            </tr>
                               </table>
                        </asp:Panel>  
 
 
<asp:Panel ID="pnlSTAXTDS" runat="server" Width="800px" >             
<table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800" id="TABLE1" onclick="return TABLE1_onclick()">
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="3">
                  <asp:CheckBox ID="Svctax_yn" runat="server" onclick="javascript:GetTotal()" /> <strong> <font  color="red">Plz Check Here to Enable Service Tax </font></strong>
                </td>
                <td style="text-align: center" class="blackfnt" colspan="2">
                  <asp:CheckBox ID="TDS_yn" runat="server" onclick="javascript:GetTotal()" /> <strong> <font  color="red">Plz Check Here to Enable TDS </font></strong>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td style="text-align: center; height: 21px;" class="blackfnt" colspan="3">
                    <strong>ADD Service Tax(+) </strong>
                </td>
                <td style="text-align: center; height: 21px;" class="blackfnt" colspan="2">
                    <strong>LESS TDS (-) </strong>
                </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td class="blackfnt" style="width: 4px; text-align: left">
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtAppl" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;Amount Applicable
                </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtAmtApplL" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" ></asp:TextBox></td>
            </tr>
             <tr style="background-color: White">
                <td style="text-align: left; width: 272px; height: 24px;" class="blackfnt">
                    &nbsp; 
                </td>
                 <td class="blackfnt" style="text-align: Right">
                     Rate</td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;</td>
                <td style="text-align: left; height: 24px;" class="blackfnt">
                    &nbsp;TDS Section
                </td>
                <td style="text-align: left; height: 24px;" class="blackfnt">&nbsp;<asp:DropDownList ID="Tdssection" runat="server" Width="200px" >
                               
                            </asp:DropDownList>
                   </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 272px; height: 26px;" class="blackfnt">
                    &nbsp;Service tax (+)
                </td>
                <td class="blackfnt" style="text-align: right">
                    <asp:Label ID="LblSTaxRate" runat="server" CssClass="blackfnt" Text=""  style="text-align: right" ></asp:Label>
                    </td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtServiceTax" runat="server" style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False"  Text="0.00"></asp:TextBox></td>
                <%--<td style="text-align: left; height: 26px;" class="blackfnt">
                    &nbsp;TDS Section
                </td>
                <td style="text-align: left; height: 26px;" class="blackfnt">
                   <asp:DropDownList ID="cboCorporate" runat="server" class="blackfnt">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                    <asp:ListItem Text="Non Corporate" Value="N"></asp:ListItem>
                </asp:DropDownList></td>--%>
                
                 <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;TDS Rate
                </td>
                 <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtTDSRate" runat="server"  style="text-align: right" BorderStyle="Groove"  Text="0.00" onchange="javascript:Nagative_Chk_wDecimalTDS(this);GetTotal()" CssClass="input" Width="80px"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: White">
                <td style="text-align: Left; width: 272px; height: 26px;" class="blackfnt">
                    &nbsp;Education Cess (+)
                </td>
                <td class="blackfnt" style=" text-align: right">
                <asp:Label ID="LblEduCess" runat="server" CssClass="blackfnt" Text=""  style="text-align: right" ></asp:Label>
                   </td>
                <td style="text-align: left" class="blackfnt"> 
                    &nbsp;<asp:TextBox ID="txtEduCess" runat="server" style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;</td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;</td>
                    
               
                                    
            </tr>
            <tr style="background-color: White">
                <td style="text-align: left; width: 272px;" class="blackfnt">
                    &nbsp;Higher Education Cess (+)
                </td>
                <td class="blackfnt" style="text-align: right" align="right">
                    <asp:Label ID="LblHEduCess" runat="server" CssClass="blackfnt" Text=""  style="text-align: right" ></asp:Label></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;<asp:TextBox ID="txtHEduCess" runat="server" style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this)" BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox></td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;</td>
                <td style="text-align: left" class="blackfnt">
                    &nbsp;</td>
                    
            </tr>
    <%--// Added By Anupam--%>
    <tr style="background-color: White">
            <td style="text-align: left; width: 272px;" class="blackfnt">
                &nbsp;Swachh Bharat Cess (+)
            </td>
            <td class="blackfnt" style="text-align: right" align="right">
                <asp:Label ID="LblSBCess" runat="server" CssClass="blackfnt" Text="" Style="text-align: right"></asp:Label>
            </td>
            <td style="text-align: left" class="blackfnt">
                &nbsp;<asp:TextBox ID="txtSBCess" runat="server" Style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this)"
                    BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox>
            </td>
            <td style="text-align: left" class="blackfnt">
                &nbsp;
            </td>
            <td style="text-align: left" class="blackfnt">
                &nbsp;
            </td>
        </tr>
    <%--// Added By Anupam--%>
         <tr style="background-color: White">
            <td style="text-align: left; width: 272px;" class="blackfnt">
                &nbsp;Krishi Kalyan Cess (+)
            </td>
            <td class="blackfnt" style="text-align: right" align="right">
                <asp:Label ID="LblKKCess" runat="server" CssClass="blackfnt" Text="" Style="text-align: right"></asp:Label>
            </td>
            <td style="text-align: left" class="blackfnt">
                &nbsp;<asp:TextBox ID="txtKKCess" runat="server" Style="text-align: right" onchange="javascript:Nagative_Chk_wDecimal(this)"
                    BorderStyle="Groove" CssClass="input" Width="80px" Enabled="False" Text="0.00"></asp:TextBox>
            </td>
            <td style="text-align: left" class="blackfnt">
                &nbsp;
            </td>
            <td style="text-align: left" class="blackfnt">
                &nbsp;
            </td>
        </tr>
    <tr style="background-color: white">
        <td class="blackfnt" style="width: 272px; text-align: left">
            &nbsp;Total Tax</td>
        <td class="blackfnt" style="width: 4px; text-align: left">
        </td>
        <td class="blackfnt" style="text-align: left">
        &nbsp;<asp:TextBox ID="txtTaxAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
        </td>
        <td class="blackfnt" style="text-align: left">
            &nbsp;TDS Amount (-)
        </td>
        <td class="blackfnt" style="text-align: left">
        &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox></td>
    </tr>
           
       <%-- <tr bgcolor="#FFFFFF">
            <td colspan="4">
                <font class="blackfnt"><b>Net Payable Amount</b></font></td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtNetPayableAmt" Font-Bold="true"  Enabled="false"  runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>--%>
        </table>
</asp:Panel>
                        
                              <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                TargetControlID="pnlSTAXTDS"
                    ExpandControlID="pnlSTAXTDSDetails" CollapseControlID="pnlSTAXTDSDetails" Collapsed="True"
                     TextLabelID="lblTDSHTAX" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
        
        
        
        <br>
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800" >
            <tr class="bgbluegrey">
                <td style="text-align: center" class="blackfnt" colspan="5">
                  Net payable
                 </td>
            </tr>
            <tr style="background-color: white">
                <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;Amount Applicable</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;Tax (+)</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;TDS(-)</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;Total</td>
            </tr>
            
            <tr style="background-color: white">
                <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;Labour</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtTotLabourApplAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtTotLabourTaxAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtLabourTDSAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtNetLabourAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
            </tr>
            <tr style="background-color: white">
                <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;Parts</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtTotPartApplAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtTotPartTaxAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtNetPartAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Enabled="False"></asp:TextBox>
                    </td>
            </tr>
            
            <tr style="background-color: white">
                <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;<b>Net Payable</b></td>
                    <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;</td>
                    <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;</td>
                    <td class="blackfnt" style="width: 272px; text-align: left">
                    &nbsp;</td>
                    <td class="blackfnt" style="width: 272px; text-align: right">
                    &nbsp;
                    <asp:TextBox ID="txtNetPayableAmt" runat="server" style="text-align: right" BorderStyle="Groove" CssClass="input"  Text="0.00" Width="80px" Font-Bold="true" Enabled="False"></asp:TextBox>
                    </td>
            </tr>            
         </table> 