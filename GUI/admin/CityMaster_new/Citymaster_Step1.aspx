<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageEnter.master" AutoEventWireup="true"
    CodeFile="Citymaster_Step1.aspx.cs" Inherits="GUI_WebAdmin_CityMaster_new_Citymaster_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
  function numberonly(event)
  {
    //debugger
    if (event.keyCode < 48 || event.keyCode > 57)
                {
                    //if (window.event.keyCode!=8 && window.event.keyCode!=14)
                    //{
                        event.keyCode=0;
                        return false;   
                    //}
                }
  }
  function checkduplicate(obj)
        {      
            var rows = document.getElementById("ctl00_MyCPH1_GV_D").rows.length;
            //rows = rows-1
            for(i=0;i<rows-1;i++)
            {
                j=i+2
                if (j<10)
                {
                        //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_ChkSelect").checked == true && obj.id != "ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_txtbranchname")
                        //{
                           if(document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+j+"_txtCityname").value == obj.value && document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+j+"_txtCityname").value != "" && obj.id != "ctl00_MyCPH1_GV_D_ctl0"+j+"_txtCityname")
                           {
                                alert("City name already exists !!")  
                                obj.focus()  
                                return false
                           }  
                        //}
                        
                }
                else
                {
                    //if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_ChkSelect").checked == true && obj.id != "ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_txtbranchname")
                    //{
                           if(document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname").value == obj.value && document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname").value != ""  && obj.id != "ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname")
                           {
                                alert("City name already exists !!")    
                                obj.focus()  
                                return false
                           }  
                    //}
                }
           }     
        }
  function oda_yn(objchk,objtxtoda,objtxtkm)
  {
    //debugger
    if (objchk.checked == true)
    {
        objtxtoda.value = "Y"
        objtxtkm.disabled = false
    }
    else if (objchk.checked == false)
    {
        objtxtoda.value = "N"
        objtxtkm.disabled = true
        objtxtkm.value = "0"
    }
  }
  function Nagative_Chk_wDecimal(obj)
        {
            //alert(obj)
            //debugger
            var a = obj.value 
	       
	        if (a == "")	
	        {
		        return true;
	        }
        	
	        if(isNaN(a))
	        {
		        alert("Value should be Numeric")
		        obj.value = ""
		        obj.focus();
		        return false;
	        } 				
        		  
	        if(parseFloat(a) < 0)
	        {
		        alert("Value should be greater than zero")
		        obj.value = ""
		        obj.focus();
		        return false;
	        }
	        return true;					   
        }
  function kmdisable()
  {
        //debugger
        var rows = document.getElementById("ctl00_MyCPH1_GV_D").rows.length
        for(i=0;i<rows-1;i++)
        {
            //ctl00$MyCPH1$GV_D$ctl02$txtCityname
            //debugger
            i=i+2
            document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+i+"_txtODA_KM").disabled=true 
        } 
  }
  function disableenter()
        {
                if (window.event.keyCode == 13)
                {
                    event.returnValue=false;
                    event.cancel = true;
                    //alert("Enter disabled")
                    return false
                }
        }
     function nwOpen(mNo)
        {
            //debugger
            window.open("popupbranch.aspx?" + mNo.id,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
            return false
        }
     function Submitdata()
    {
	    //debugger
	    Form_name="ctl00$MyCPH1$"  
        //maxrows=parseInt(document.getElementById(Form_name+"roww").value)
        var rows = document.getElementById("ctl00_MyCPH1_GV_D").rows.length
        var maxrows = document.getElementById("ctl00_MyCPH1_GV_D").rows.length
        var onecheck=false
		for(i=0;i<rows-1;i++)
        {
            //ctl00$MyCPH1$GV_D$ctl02$txtCityname
            //debugger
            
            j=i+2
            if (j<10)
            {
                if (document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+j+"_txtCityname").value != "")
                {
                    onecheck=true
                }
            }
            else
            {
                //document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname").disabled=false
                if (document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname").value != "")
                {
                    onecheck=true
                }
            }    
        }
        if (onecheck == false) 
        {
            alert("Please Enter Atlist One City")
            return false;
        }
        if (maxrows>=1)
        {
		     for(i=0;i<maxrows-1;i++)
			 {
			     j = i + 2;
	           
	            if(i < 10)
                {
                                       
                    frm3=Form_name+"GV_D$ctl"+"0"+j+"$"
                }
                else
                {
                    frm3=Form_name+"GV_D$ctl"+j+"$"
                   
                }
                   
             
			   if (document.getElementById(frm3+"txtCityname").value!="")		
			   {
				 if(document.getElementById(frm3+"ddState").value=="")
				  {
				   alert("Please Select State")
				   document.getElementById(frm3+"ddState").focus();
				   return false;
				  }
				  if(document.getElementById(frm3+"ddZone").value=="")
				  {
				   alert("Please Select Zone")
				   document.getElementById(frm3+"ddZone").focus();
				   return false;
				  }
			   }
			}
	  }
	    
        for(i=0;i<rows-1;i++)
        {
            //ctl00$MyCPH1$GV_D$ctl02$txtCityname
            //debugger
            j=i+2
            if (j<10)
            {
                document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+j+"_txtODA_KM").disabled=false
                document.getElementById("ctl00_MyCPH1_GV_D_ctl0"+j+"_txtODA").disabled=false
                
            }
            else
            {
                document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtODA_KM").disabled=false
                document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtODA").disabled=false
            }    
        } 
}
var City_str="<%=City_str%>"
var cityid="<%=cityid%>"
var bool=false
function Citycheck(obj,objhid)
{
       //debugger
       obj.value = trimAll(obj.value);
       if (obj.value!="")
        {
            if(obj.value.length<3)
  			    {
  				    alert("Invalid City Name Length")
  				    obj.focus();
				    return false;
  			    }
                var a;
                a=1;
                //alert(cityarray)
                obj.value = obj.value.toUpperCase()
                for(i=0;i<cityarray.length;i++)
                {
                
                  if (document.getElementById("mode").value == "add")
                  {  

                        if(obj.value==trimAll(cityarray[i]))
                        {
                            a=2
                            break;
                        }
                        else
                        {
                            continue
                        }
                  }
                  else if (document.getElementById("mode").value == "edit")
                  {
                        if(obj.value==trimAll(cityarray[i]) && obj.value!=objhid.value)
                        {
                            a=2
                            break;
                        }
                        else
                        {
                            continue
                        }
                  }   
                }
                
                if (a==2)
                {
                    alert("City already exists !!")
                    bool=true
                    obj.focus();
                    return false
                }
  	    }
}
//  			    if(cityid=="")
//  			    {
//                    if(City_str.indexOf(obj.value)!=-1 )
//  			        {
//  				        alert("City Name Already Exist")
//  				        obj.focus();
//				        return false;
//  			        }
//  			     }
//  			     else
//  			     {
//  			        if(cityid!=obj.value)
//  			        {
//  			             if(City_str.indexOf(obj.value)!=-1 )
//  			                {
//  				                alert("City Name Already Exist")
//  				                obj.focus();
//				                return false;
//  			                }
//  			        }
//  			     }
function trimAll(strValue) 
        {
            //Trimming left most white space characters
            while (strValue.substring(0,1) == ' ')
            {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length-1, strValue.length) == ' ')
            {
                strValue = strValue.substring(0, strValue.length-1);
            }
            
            return strValue;
        }
 function checklocation(obj)
       {
        //debugger
            obj.value = trimAll(obj.value);
            if (obj.value != "")
            {
                var a;
                a=1;
                obj.value = obj.value.toUpperCase()
                for(i=0;i<str.length;i++)
                {
                    if(obj.value==str[i])
                    {
                        a=2
                        break;
                    }
                    else
                    {
                        continue
                    }
                }
                //debugger
                if (a!=2)
                {
                    alert("please enter valid location")
                    obj.value=""
                    obj.focus();
                    return false
                }
            }
       }
       
    </script>
    <div align="left" style="width: 10in">
    <asp:HiddenField ID="mode" runat="server" />
<asp:ScriptManager ID="script" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="DataGrid2_Update" runat="server"    UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>
            &nbsp;<br />
            <div align="left" style="width: 10in">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Administrator</b></font></a> <b>&gt; </b><a href="../company_structure.aspx"><font
                        class="blklnkund"><b>Company Structure</b></font></a> <b>&gt; </b><font class="bluefnt">
                            <b>City Master</b></font></div>
            <div align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a></div>
            <table runat="server" id="tblrow" border="0" cellpadding="1" cellspacing="1" class="boxbg"
                align="center">
                <tr runat="server" id="trrow" bgcolor="white">
                    <td align="left">
                        <font class="bluefnt">Enter Row No *</font></td>
                    <td style="height: 40px">
                        <asp:TextBox ID="roww" onkeypress="return numberonly(event)" runat="server" Width="40px"
                            BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25"></asp:TextBox></td>
                    <td>
                    </td>
                </tr>
                <%--onblur="return Nagative_Chk_wDecimal(this)"  onchange="return Nagative_Chk_wDecimal(this)"--%>
            </table>
            <br />
            <br />
            <%--<asp:GridView id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />--%>
            <div align="left">
                <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                    PagerStyle-HorizontalAlign="left" BackColor="white" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                    AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="GV_D_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="City Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="100px" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" Width="150px" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtCityname" runat="server" BorderStyle="Groove"></asp:TextBox>
                                <asp:HiddenField ID="HidCityName" runat="server" />
                             <%--   <atlas:AutoCompleteExtender ID="Extender1" runat="server">
                                    <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetCItyList"
                                        ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtCityname" />
                                </atlas:AutoCompleteExtender>--%>
                                
                                  <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                ServiceMethod="GetCItyList" ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtCityname">
                                            </ajaxToolkit:AutoCompleteExtender>
                                <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                          <ContentTemplate>--%>
                                <%--<asp:Label ID="lbvalidate" Visible="false" runat="server" Text="Sorry City Duplicate For this State !!!" CssClass="blackfnt" ForeColor="Red"></asp:Label>--%>
                                <%--</ContentTemplate>    </asp:UpdatePanel>  --%>
                                <%--<asp:TextBox ID="txtddd" runat="server"   Visible="false" ></asp:TextBox>--%>
                            </ItemTemplate>
                            <%--<FooterTemplate>
                                                                                      <asp:Label ID="lblttt" CssClass="blackfnt"  runat="server">Total : </asp:Label>
                                                                                   
                                                                              </FooterTemplate>--%>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="State">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:DropDownList ID="ddState" runat="server">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Region">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:DropDownList ID="ddZone" runat="server">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Road Bkg. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtRoadBKG_loc" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                                     Width="15px"></asp:Label>--%>
                                <asp:Button ID="cmdRoadBKG_loc" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Road Dely. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtRoaddly_loc" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                <asp:Button ID="cmdRoaddly_loc" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Air Bkg. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtAirBKG_loc" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                <asp:Button ID="cmdAirBKG_loc" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Air Dely. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtAirdly_loc" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                <asp:Button ID="cmdAirdly_loc" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rail Dely. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtRailBKG_loc" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                <asp:Button ID="cmdRailBKG_loc" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rail Dely. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtRaildly_loc" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                                <asp:Button ID="cmdRaildly_loc" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ODA YN">
                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <%-- <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                                                <ContentTemplate> --%>
                                <asp:CheckBox ID="chk11" runat="server" />
                                <asp:TextBox ID="txtODA" Enabled="false" runat="server" Width="22px" Text="N" Font-Bold="true"></asp:TextBox>
                                <%-- <asp:TextBox ID="txtODA" Width="30" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>--%>
                                <%--</ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="chk11" EventName="CheckedChanged" />
                                                                </Triggers>
                                                            </asp:UpdatePanel>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ODA Km.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtODA_KM" Width="30" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>                                
                                <asp:CheckBox ID="chkStatus" runat="server" />                                
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="City Name In Hindi">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtHindiCityname" runat="server" BorderStyle="Groove"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                </asp:GridView>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <div align="center" style="width:10in">
    <asp:Button ID="Button11" OnClick="Button11_Click" runat="server" Text="Submit" TabIndex="9" />
    </div>
    </div> 
</asp:Content>
