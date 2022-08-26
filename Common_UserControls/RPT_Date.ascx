<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RPT_Date.ascx.cs" Inherits="GUI_UNI_MIS_RPT_Date" %>
<link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript">


        var FinYear="<%=Session["FinYear"]%>"
        var FinYear_to=parseInt(FinYear)+1

        if(FinYear_to<10)
        {
        FinYear_to="0"+FinYear_to
        }
        var FinYear_fromdate="01/04/"+FinYear
        var FinYear_todate="31/03/"+FinYear_to
        var Sle_finyear=FinYear+"-"+FinYear_to
        
        	var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");
    


    function FinDateCheck()
    {
        var Selection=document.getElementById("ctl00_MyCPH1_DT_radDate_0");
        var txtDateFrom=document.getElementById("ctl00_MyCPH1_DT_txtDateFrom");
        var txtDateTo=document.getElementById("ctl00_MyCPH1_DT_txtDateTo");
        
        		 var dt =txtDateFrom.value			
               // alert(dt)
	            var dt_dd=dt.substring(0,2)	
	            var dt_mm=dt.substring(3,5)
	            var dt_yy=dt.substring(6,10)
		            
	           var fromdt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	           // alert(" hi .." + dt)
	          var dt1 =txtDateTo.value			
                //alert(dt)
	            var dt_dd1=dt1.substring(0,2)	
	            var dt_mm1=dt1.substring(3,5)
	            var dt_yy1=dt1.substring(6,10)
		            //alert(" hi .." + dt1)
	          var todt=new Date(months[parseFloat(dt_mm1)] + " " + parseFloat(dt_dd1) + ", " + parseFloat(dt_yy1))
	            //alert(bgndt)
	            
            	
	           var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
                var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
                var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
                FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

                var FinYear_todate_dd=FinYear_todate.substring(0,2)
                var FinYear_todate_mm=FinYear_todate.substring(3,5)
                var FinYear_todate_yy=FinYear_todate.substring(6,10)
                FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))

                if (fromdt>FinYear_todate1 || fromdt<FinYear_fromdate1)
                {
                alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
                txtDateFrom.focus();
                return false;
                }
                
                if (todt>FinYear_todate1 || todt<FinYear_fromdate1)
                {
                alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
                txtDateTo.focus();
                return false;
                }
    
        return true;
    }
    function DateCheck()
    {
        var Selection=document.getElementById("ctl00_MyCPH1_DT_radDate_0");
        var txtDateFrom=document.getElementById("ctl00_MyCPH1_DT_txtDateFrom");
        var txtDateTo=document.getElementById("ctl00_MyCPH1_DT_txtDateTo");
        

        
        if (document.getElementById("ctl00_MyCPH1_DT_radDate_0").checked==true)
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
			 
			 
			 var dt =txtDateFrom.value			
                //alert(dt)
	            var dt_dd=dt.substring(0,2)	
	            var dt_mm=dt.substring(3,5)
	            var dt_yy=dt.substring(6,10)
		            
	           var fromdt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	           // alert(" hi .." + dt)
	          var dt1 =txtDateTo.value			
                //alert(dt)
	            var dt_dd1=dt1.substring(0,2)	
	            var dt_mm1=dt1.substring(3,5)
	            var dt_yy1=dt1.substring(6,10)
		          //  alert(" hi .." + dt1)
	          var todt=new Date(months[parseFloat(dt_mm1)] + " " + parseFloat(dt_dd1) + ", " + parseFloat(dt_yy1))
	            //alert(bgndt)
            			
	            currdate="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
	            dt_dd=currdate.substring(0,2)
	            dt_mm=currdate.substring(3,5)
	            dt_yy=currdate.substring(6,10)
	           // alert("hi")
	            currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            		
            	//alert(currdate)
	            if (currdate < fromdt)
	            {
			            alert("From Date should be less than or equal to  system Date \n")
			            txtDateFrom.focus();
			            return false;
	            }
	            
	            if (currdate < todt)
	            {
			            alert("To Date should be less than or equal to  system Date \n")
			            txtDateTo.focus();
			            return false;
	            }
            		
            	if (todt < fromdt)
	            {
			            alert("To Date should be Greter than From Date \n")
			            txtDateTo.focus();
			            return false;
	            }
	            
	            if (todt < fromdt)
	            {
			            alert("From Date should be less than To Date \n")
			            txtDateFrom.focus();
			            return false;
	            }
            
        }
        return true;
        
    }
    
</script>


<div>
    <div id="tabs" style="text-align: left; padding: 0px 0px 0px 0px; color: Black; border-bottom-color: DarkGray">
        <table cellspacing="1" cellpadding="3" border="0" class="boxbg" style="width: 100%">
            <tr style="background-color: white" runat="server">
              
                    <td>
                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                            Width="210px">
                            <asp:ListItem  Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                            <asp:ListItem Selected="True" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                            <%-- <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>--%>
                        </asp:RadioButtonList>
                    </td>
                    <td valign="top" colspan="5">
                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: " ></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="60" onblur="javascript:isValidDate(this.value,'From Date!!!')"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$DT$txtDateFrom,'anchor1','dd/MM/yyyy');ctl00$MyCPH1$DT$radDate[0].checked=true; return false;"
                            name="anchor1" id="anchor1">
                            <img src="../images/calendar.jpg" runat="server" id="imgfrm" border="0" />
                        </a>
                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="60" onblur="javascript:isValidDate(this.value,'To Date!!!')"
                            MaxLength="10"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$DT$txtDateTo,'anchor2','dd/MM/yyyy');ctl00$MyCPH1$DT$radDate[0].checked=true; return false;"
                            name="anchor2" id="a1">
                            <img src="../images/calendar.jpg"  runat="server" id="imgto" border="0" />
                        </a>
                    </td>
            </tr>
        </table>
    </div>
</div>
