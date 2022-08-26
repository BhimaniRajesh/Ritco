<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="RemouldTyre.aspx.cs" Inherits="Tyre_Remould" %>

   <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
    <script type="text/javascript" language="javascript" src="../../Js/Date.js"></script>

<script language="javascript">
    var controlIdPrefix = "ctl00_MyCPH1_";
    var controlIdPrefix1 = "gv_Remould__ctl02_";
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function fncInputNumericValuesOnly()
	{
		if(!(event.keyCode==45||event.keyCode==46||event.keyCode==48||event.keyCode==49||event.keyCode==50||event.keyCode==51||event.keyCode==52||event.keyCode==53||event.keyCode==54||event.keyCode==55||event.keyCode==56||event.keyCode==57))
		{
			event.returnValue=false;
		}
	}
	function chkValidRemouldDate(tb_Remould_Date,lbl_Remould_Date_Err)
	{
	    if(tb_Remould_Date.value=="")
        {
            lbl_Remould_Date_Err.innerText = "!!!";
            tb_Remould_Date.style.borderColor="red";
            return false;
        }
        else
        {
            if(!isDate(tb_Remould_Date.value,"dd/mm/yyyy"))
            {
                lbl_Remould_Date_Err.innerText = "Invalid Date";
                tb_Remould_Date.style.borderColor="red";
                tb_Remould_Date.focus();
                return false;
            }
            else
            {
                lbl_Remould_Date_Err.innerText = "";
                tb_Remould_Date.style.borderColor="";
            }
        }
	}
    function chkValidRemouldCost(tb_Remould_Cost,lbl_Remould_Cost_Err)
    {
        if(tb_Remould_Cost.value=="")
        {
            lbl_Remould_Cost_Err.innerText = "!!!";
            tb_Remould_Cost.style.borderColor="red";
            return false;
        }
        else
        {
            lbl_Remould_Cost_Err.innerText = "";
            tb_Remould_Cost.style.borderColor="";
        }
               
    }
    function chkValidTWI(tb_Avg_TWI_Remould,lbl_Avg_TWI_Remould_Err)
    {
        if(tb_Avg_TWI_Remould.value=="")
        {
            lbl_Avg_TWI_Remould_Err.innerText = "!!!";
            tb_Avg_TWI_Remould.style.borderColor="red";
            return false;
        }
        else
        {
            lbl_Avg_TWI_Remould_Err.innerText = "";
            tb_Avg_TWI_Remould.style.borderColor="";
        }
    }
    function checkValidPattern(ddl_Tyre_Pattern,lbl_Tyre_Pattern_Err)
    {
        if(ddl_Tyre_Pattern.value=="0")
        {
            lbl_Tyre_Pattern_Err.innerText = "!!!";
            return false;
        }
        else
        {
            lbl_Tyre_Pattern_Err.innerText = "";
        }
    }
   
    function CheckTyreNo(row_Index,tb_tyre_no,tb_Current_KM,tb_Purchase_Cost,hf_tyre_id,tb_Pattern,tb_Current_TDM,lbl_Tyre_No_Error)
    {
        var currentTime = new Date()
        var str_Index = "";
        if (tb_tyre_no.value == "")
        {
            tb_tyre_no.value="";
            tb_Current_KM.innerText="";
            tb_Purchase_Cost.innerText="";
            hf_tyre_id.value="";
            tb_Pattern.innerText="";
            tb_Current_TDM.innerText="";
            lbl_Tyre_No_Error.innerText="";
            return;
        }
        var gv_Remould = document.getElementById(controlIdPrefix + "gv_Remould");
        for (intIndex = 2; intIndex <= gv_Remould.rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (row_Index == intIndex - 2)
            {
                continue;
            }
            if (document.getElementById(controlIdPrefix + "gv_Remould_ctl" + str_Index + "_tb_tyre_no").value == tb_tyre_no.value)
            {
                lbl_Tyre_No_Error.innerText="This Part already exist at row " + (intIndex - 1);
                tb_tyre_no.focus();
                return false;
            }
        }
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        lbl_Tyre_No_Error.innerText="Invalid Tyre Number";
                        tb_Current_KM.innerText="";
                        tb_Purchase_Cost.innerText="";
                        hf_tyre_id.value="";
                        tb_Pattern.innerText="";
                        tb_Current_TDM.innerText="";
                        tb_tyre_no.focus();
                        return false;
                    }
                    else
                    {
                        if (returnValue[8] == "Mounted") 
                        {
                            lbl_Tyre_No_Error.innerText="Tyre was mounted,hence tyre can not be remould!!!";
                            tb_Current_KM.innerText="";
                            tb_Purchase_Cost.innerText="";
                            hf_tyre_id.value="";
                            tb_Pattern.innerText="";
                            tb_Current_TDM.innerText="";
                            tb_tyre_no.focus();
                            return false;
                        }
                        else
                        {
                            if (returnValue[8] == "Scrapped") 
                            {
                                lbl_Tyre_No_Error.innerText="Tyre was scrapped,hence tyre can not be remould!!!";
                                tb_Current_KM.innerText="";
                                tb_Purchase_Cost.innerText="";
                                hf_tyre_id.value="";
                                tb_Pattern.innerText="";
                                tb_Current_TDM.innerText="";
                                tb_tyre_no.focus();
                                return false;
                            }
                            else
                            {
                                lbl_Tyre_No_Error.innerText="";
                                hf_tyre_id.value=returnValue[1];
                                tb_tyre_no.value=returnValue[2];
                                tb_Current_TDM.innerText=returnValue[3];
                                tb_Current_KM.innerText=returnValue[5];
                                tb_Purchase_Cost.innerText=returnValue[6];
                                tb_Pattern.innerText=returnValue[7];
                                checkBlankCtl();
                            }
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidTyreIDRemould&datetime="+currentTime+"&TyreID=" + tb_tyre_no.value, false);
            xmlHttpRequest.send(null);
        }	
    }
    function checkBlankCtl()
    {
        var tot_rows=document.getElementById(controlIdPrefix + "gv_Remould").rows.length;
        var tb_tyre_no="";
        var TYID1="";
        var TYID2="";
        if(tot_rows>0)
        {
            for(i=0;i< tot_rows-1;i++)
            {  
                j=i+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_gv_Remould_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_gv_Remould_ctl" + j + "_";
                }    
                tb_tyre_no=document.getElementById(pref + "tb_tyre_no");
                TYID1=document.getElementById(pref + "tb_tyre_no").value ;
                
                var lbl_Tyre_No_Error=document.getElementById(pref + "lbl_Tyre_No_Error");
                
                var tb_Remould_Date=document.getElementById(pref + "tb_Remould_Date");
                var lbl_Remould_Date_Err=document.getElementById(pref + "lbl_Remould_Date_Err");

                var ddl_Tyre_Pattern=document.getElementById(pref + "ddl_Tyre_Pattern");
                var lbl_Tyre_Pattern_Err=document.getElementById(pref + "lbl_Tyre_Pattern_Err");

                var tb_Remould_Cost=document.getElementById(pref + "tb_Remould_Cost");
                var lbl_Remould_Cost_Err=document.getElementById(pref + "lbl_Remould_Cost_Err");

                var tb_Avg_TWI_Remould=document.getElementById(pref + "tb_Avg_TWI_Remould");
                var lbl_Avg_TWI_Remould_Err=document.getElementById(pref + "lbl_Avg_TWI_Remould_Err");
                
                var ddl_Vendor=document.getElementById(pref + "ddl_Vendor");
                var lbl_ddl_Vendorn_Err=document.getElementById(pref + "lbl_ddl_Vendorn_Err");
                
                if(tb_tyre_no.value=="")
                {
                    lbl_Tyre_No_Error.innerText = "!!!";
                    tb_tyre_no.style.borderColor="red";
                    return false;
                }
                else
                {
                    lbl_Tyre_No_Error.innerText = "";
                    tb_tyre_no.style.borderColor="";
                }
                if(tb_Remould_Date.value=="")
                {
                    lbl_Remould_Date_Err.innerText = "!!!";
                    tb_Remould_Date.style.borderColor="red";
                    return false;
                }
                else
                {
                    if(!isDate(tb_Remould_Date.value,"dd/mm/yyyy"))
                    {
                        lbl_Remould_Date_Err.innerText = "Invalid Date";
                        tb_Remould_Date.style.borderColor="red";
                        tb_Remould_Date.focus();
                        return false;
                    }
                    else
                    {
                        lbl_Remould_Date_Err.innerText = "";
                        tb_Remould_Date.style.borderColor="";
                    }
                }
                if(ddl_Tyre_Pattern.value=="0")
                {
                    lbl_Tyre_Pattern_Err.innerText = "!!!";
                    return false;
                }
                else
                {
                    lbl_Tyre_Pattern_Err.innerText = "";
                }
                
                if(ddl_Vendor.value == "0")
                {
                    lbl_ddl_Vendorn_Err.innerText="Select Vendor!!!";
                    return false;
                }
                else
                {
                    lbl_ddl_Vendorn_Err.innerText = "";
                }
                if(tb_Remould_Cost.value=="")
                {
                    lbl_Remould_Cost_Err.innerText = "!!!";
                    tb_Remould_Cost.style.borderColor="red";
                    return false;
                }
                else
                {
                    lbl_Remould_Cost_Err.innerText = "";
                    tb_Remould_Cost.style.borderColor="";
                }
                if(tb_Avg_TWI_Remould.value=="")
                {
                    lbl_Avg_TWI_Remould_Err.innerText = "!!!";
                    tb_Avg_TWI_Remould.style.borderColor="red";
                    return false;
                }
                else
                {
                    lbl_Avg_TWI_Remould_Err.innerText = "";
                    tb_Avg_TWI_Remould.style.borderColor="";
                }
                
                if(TYID1!="")
                {
                    for(k=0;k<tot_rows-1;k++)
                    {  
                        if(i!=k)
                        {
                            m=k+2
                            var pref="";
                            if(j<10)
                            {
                                pref = "ctl00_MyCPH1_gv_Remould_ctl0" + m + "_";
                            }                                       
                            else
                            {         
                                pref = "ctl00_MyCPH1_gv_Remould_ctl" + m + "_";
                            }    
                            TYID2=document.getElementById(pref + "tb_tyre_no").value ;
                            if(TYID1==TYID2)
                            {
                                alert("Please Select different Tyre ID in each row!");
                                document.getElementById(pref + "tb_tyre_no").focus();
                                return false;
                            }
                        }
                    }
                    
                }
            }
        }
    }
  
</script>
<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div align="left">
<br />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Remould Tyre</asp:Label>
                
            </td>
        </tr>
    </table>
<br />
<hr />
<br />
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="30%">
        <tr bgcolor="white">
            <td class="blackfnt" colspan="2"><strong>Enter Row No *</strong></td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                        
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
   <br />
  
       <br />
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="1100px">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:GridView ID="gv_Remould" runat="server" 
                                CellPadding="3" 
                                CellSpacing="1" 
                                HeaderStyle-CssClass="bgbluegrey"
                                AutoGenerateColumns="False" 
                                SelectedIndex="1" 
                                OnRowDataBound="gv_Remould_RowDataBound" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </center>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tyre No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_tyre_no"  CssClass="input" Width="100px" Text='<%#Eval("Tyre_Id")%>' BorderStyle="groove"  runat="server"></asp:TextBox>
                                        <asp:Button ID="btnPopupTyre" runat="server" Text="..." />
                                        <asp:Label ID="lbl_Tyre_No_Error" runat="server" Font-Size="Small" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                                        <asp:HiddenField ID="hid_Tyre_Cost"  runat="server"></asp:HiddenField>
                                        <asp:HiddenField ID="hf_tyre_id"  runat="server"></asp:HiddenField>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="30%" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Capture&lt;br&gt;KM">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Current_KM" Text='<%#Eval("Capture_KM")%>' runat="server" Width="70px"  style="font-size: 8pt; color: black; font-family: Verdana; text-align: center" BorderStyle="None"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remould Date&lt;br&gt;(dd/mm/yyyy)">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:TextBox id="tb_Remould_Date" runat="server" Columns="6" Width="60px" CssClass="input"  Text='<%#Eval("Remould_Date")%>'    MaxLength="10" BorderStyle="Groove"/>
	                                  <%--<asp:Image id="img_Calendar" runat="server" ImageUrl="~/gui/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:Image>--%>   
	                                 <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="tb_Remould_Date" runat="server" />       
                                    <asp:Label ID="lbl_Remould_Date_Err" runat="server" Font-Size="Small" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                                    </ItemTemplate>
                                     <ItemStyle Width="15%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText ="Current&lt;br&gt;Pattern">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Pattern"  Text='<%#Eval("Tyre_Pattern")%>'   runat="server" Width="50px" style="font-size: 8pt; color: black; font-family: Verdana; text-align: center" BorderStyle="None"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText ="New Tyre&lt;br&gt;Pattern">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList  ID="ddl_Tyre_Pattern" runat="server">
                                        </asp:DropDownList>
                                        <asp:Label ID="lbl_Tyre_Pattern_Err" runat="server" Font-Size="Small" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vendor">
                                   <ItemTemplate>
                                   <%--<%# Bind("VENDORCODE") %>--%>
                                       <asp:DropDownList ID="ddl_Vendor" Width="200px"  runat="server" />
                                       <asp:Label ID="lbl_ddl_Vendorn_Err" runat="server" Font-Size="Small" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText ="Tyre &lt;br&gt;Purchase Cost">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Purchase_Cost" runat="server"  Text='<%#Eval("Tyre_Purchase_Cost")%>' Width="40px" style="font-size: 8pt; color: black; font-family: Verdana; text-align: center" BorderStyle="None"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText ="Remould Cost">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID = "tb_Remould_Cost"  onkeypress= "fncInputNumericValuesOnly()" runat="server"  Text='<%#Eval("Remould_Cost")%>' CssClass="input" BorderStyle="Groove" Width="73px"></asp:TextBox>
                                        <asp:Label ID="lbl_Remould_Cost_Err" runat="server" Font-Size="Small" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText ="Current &lt;br&gt;Tread Depth">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Current_TDM" runat="server"   Text='<%#Eval("TYRE_TREAD_DEPTH_32NDS")%>' Width="50px" style="font-size: 8pt; color: black; font-family: Verdana; text-align: center" BorderStyle="None"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Average TWI &lt;br&gt;after Remould">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%#Eval("Averate_TWI_Remould")%>' CssClass="input" Width="60px"  BorderStyle="Groove" Id="tb_Avg_TWI_Remould">
                                    </asp:TextBox>
                                    <asp:Label ID="lbl_Avg_TWI_Remould_Err" runat="server"  Font-Size="Small"  Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="bgbluegrey" />
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>

    <br />

    <table id="Table5" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="80%">
        <tr bgcolor="#eeeeee">
            <td class="blackfnt" colspan="1">
            <center>
                   <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return checkBlankCtl()"  OnClick="btn_Submit_Click" />    
                   </center>
                           </td>
        </tr>
    </table>
 <br />
    <font class="blackfnt" style="color:Red;">
        <asp:Panel ID="pnl_Error_List"  Visible="false"  GroupingText="Errors"  runat="server" BorderColor="Red" BorderStyle="Solid" BorderWidth="0px" Width="500px" >
            <table style="width: 100%">
                <tr runat="server" id="row_Tyre_No_Error" visible="false">
                    <td style="width: 10%; height: 20px; color: red; text-align: center;">*</td>
                    <td style="width: 90%; height: 20px">
                        
                    </td>
                </tr>
                <tr runat="server" id="row_Page_Error" visible="false">
                    <td style="width: 10%; height: 20px; color: red; text-align: center;">*</td>
                    <td style="width: 90%; height: 20px">
                        <asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        
            <table style="width: 100%">
                <tr runat="server" id="Tr1" visible="false">
                    <td style="width: 10%; height: 20px; color: red; text-align: center;">
                        <asp:Label ID="lbl_Sumit" runat="server" ></asp:Label>
                    </td>
                
                </tr>
        </table>
        
    </font>
       <br />
   
</div>
</asp:Content>
