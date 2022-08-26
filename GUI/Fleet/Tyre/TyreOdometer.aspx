<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyreOdometer.aspx.cs" Inherits="Tyre_Remould" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
   
<script language="javascript">
    var controlIdPrefix = "ctl00_MyCPH1_";
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkOdoReader(txtOdometerRead)
    {
        if (isNaN(txtOdometerRead.value)) 
        {
            alert("Enter Odometer Reading in numeric!!!"); 
            txtOdometerRead.value = ""; 
            txtOdometerRead.focus();    
            return false;
        }
    }
    function checkVehNo(row_Index,txtVehicleNo,hfVehid,txtCurKM)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtVehicleNo.value == "")
        {
            txtVehicleNo.value="";
            hfVehid.value="";
            txtCurKM.value="";
            return;
        }
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvOdometer").rows.length; intIndex++)
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
            if (document.getElementById("ctl00_MyCPH1_gvOdometer_ctl" + str_Index + "_txtVehicleNo").value == txtVehicleNo.value)
            {
                alert("This Vehicle No is already exist at row " + (intIndex - 1));
                txtVehicleNo.value = "";
                txtVehicleNo.focus();
                return;
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
                        alert("Invalid Vehicle Number");
                        txtVehicleNo.value="";
                        txtCurKM.value="";
                        hfVehid.value="";
                        txtVehicleNo.focus();
                    }
                    else
                    {
                        if(returnValue[5]=="In Transit")
                        {
                            alert("Vehicle Number " + returnValue[1] + " is already attached with Tripsheet No " + returnValue[4] + ", hence Odometer Reading can not be changed.");
                            txtVehicleNo.value="";
                            txtCurKM.value="";
                            hfVehid.value="";            
                        }
                        else
                        {
                            txtVehicleNo.value=returnValue[1];
                            if(returnValue[2]!="")
                            {
                                txtCurKM.value=returnValue[2];
                            }
                            else
                            {
                                txtCurKM.value="0.00";
                            }
                            hfVehid.value=returnValue[3];
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetVehIDKM&datetime="+currentTime+"&VehNo=" + txtVehicleNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function checkTyreId1()
    {
        var tot_rows=document.getElementById(controlIdPrefix + "gvOdometer").rows.length;
        var tyreId="";
        var TYID1="";
        var TYID2="";
        var txtOdometerRead="";
        var txtOdoReadDate="";
        var ddlReason="";
        if(tot_rows>0)
        {
            for(i=0;i< tot_rows-1;i++)
            {  
                j=i+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_gvOdometer_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_gvOdometer_ctl" + j + "_";
                }    
                tyreId=document.getElementById(pref + "txtVehicleNo").value;
                TYID1=document.getElementById(pref + "txtVehicleNo").value;
                txtOdometerRead=document.getElementById(pref + "txtOdometerRead").value;
                txtOdoReadDate=document.getElementById(pref + "txtOdoReadDate").value;
                ddlReason=document.getElementById(pref + "ddlReason").value;
                if(tyreId=="")
                {
                    alert("Enter Vehicle Number!!!");
                    document.getElementById(pref + "txtVehicleNo").focus();
                    return false;
                }
                
                if(txtOdometerRead=="")
                {
                    alert("Enter New Odometer Reading!!!");
                    document.getElementById(pref + "txtOdometerRead").focus();
                    return false;
                }
                if(txtOdoReadDate=="")
                {
                    alert("Enter Odometer Date!!!");
                    document.getElementById(pref + "txtOdoReadDate").focus();
                    return false;
                }
                if(ddlReason=="0")
                {
                    alert("Select Odometer Reason!!!");
                    document.getElementById(pref + "ddlReason").focus();
                    return false;
                }
                
                
                for(k=0;k<tot_rows-1;k++)
                {  
                    if(i!=k)
                    {
                        m=k+2
                        var pref="";
                        if(j<10)
                        {
                            pref = "ctl00_MyCPH1_gvOdometer_ctl0" + m + "_";
                        }                                       
                        else
                        {         
                            pref = "ctl00_MyCPH1_gvOdometer_ctl" + m + "_";
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
    function CheckKM(tb_Capture_KM)
    {
        if (isNaN(tb_Capture_KM.value)) 
        {
            alert("Invalid KM"); 
            tb_Capture_KM.value = ""; 
            tb_Capture_KM.focus();
            return false;
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

<div >
    <table cellspacing="1" style="width: 40%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Vehicle Odometer Module</asp:Label>
                
            </td>
        </tr>
    </table>

    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="25%">
        <tr  bgcolor="white">   
            <td width="40%" class="blackfnt"  colspan="2"><strong>Enter Row No *</strong></td>
            <td width="60%" align="left" class="blackfnt" colspan="2">
                <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="80%">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="text-align: right" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                    
                        <asp:GridView ID="gvOdometer" runat="server" CellPadding="3" CellSpacing="1" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="gvOdometer_RowDataBound" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr. No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtVehicleNo"  CssClass="input" Width="98px" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnPopupVehNo" runat="server" Text="..." />
                                        <asp:HiddenField ID="hfVehid"  runat="server"></asp:HiddenField>
                                  
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Current reading KM">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtCurKM"  CssClass="input" Width="60px" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                                   
                                <asp:TemplateField HeaderText="Odometer Reading">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:TextBox runat="server" CssClass="input" Width="60px" Id="txtOdometerRead">
                                    </asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                               
                                 <asp:TemplateField HeaderText="Odometer Reading Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:textbox id="txtOdoReadDate" runat="server" Columns="6" Width="60px" CssClass="input"   MaxLength="10" BorderStyle="Groove"></asp:textbox>
	                                <%--<asp:Image id="img_Calendar" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:Image>--%>   
	                                 <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtOdoReadDate" runat="server" />       
                                    </ItemTemplate>
                                     <ItemStyle Width="20%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reason">
                                    <ItemStyle HorizontalAlign="Left" Width="30%" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlReason" runat="server" Width="241px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
                   </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="text-align: center" >
                <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return checkTyreId1()"  OnClick="btn_Submit_Click" />
            </td>
            </tr>
    </table>

    <br />

    <br />
    
    <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
</div>
</asp:Content>
