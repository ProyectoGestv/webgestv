# -*- encoding : utf-8 -*-
require 'net/http'
class UploadsController < ApplicationController

  def new
    java_types = { 'java.lang.Boolean' => 'Boolean',
                   'java.lang.String' => 'String',
                   'java.lang.Integer' => 'Integer',
                   'java.lang.Double' => 'Double',
                   'java.lang.Float' => 'Float'
    }
    session[:return_to]=request.referer
    tmp = params[:mr][:file].tempfile
    f=File.open(tmp)
    doc = Nokogiri::XML(f)
    f.close
    @mr = nil
    if doc.errors.empty?
      @mr=ManRsc.find(params[:id])
      doc.xpath('//myManRes/macroAttributes/myMBeanInfo').each do |n1|
        mcr=McrAtr.new
        mcr.name=n1.attribute('name')
        mcr.desc=n1.attribute('description')
        mcr.ref_prot=n1.attribute('referenceProtocol')
        mcr.tipo=n1.attribute('type')
        n1.elements.each do |n2|
          if n2.name == 'attributes'
            n2.elements.each do |n3|
              atr=Atr.new
              atr.name=n3.attribute('name')
              atr.desc=n3.attribute('description')
              atr.ref_prot=n3.attribute('referenceProtocol')
              atr.tipo=java_types["#{n3.attribute('type')}"]
              atr.rdbl=n3.attribute('isReadable')
              atr.wtbl=n3.attribute('isWritable')
              n3.elements.each do |n4|
                atr.value=n4.text if n4.name == 'value'
              end
              atr.mcr_atr=mcr
            end
          end
        end
        mcr.man_rsc=@mr
      end
    end
    respond_to do |format|
      format.html # upload_new.html.haml
      format.json { render json: @mr }
    end
  end



  def load
    puts params
    @mr = ManRsc.find(params[:id])
    mcr_atrs=nil
    params.each do |key, value|
      if %w{serv net_ele laynet_ele}.include?(key)
        mcr_atrs=params[key][:mcr_atrs_attributes]
        break
      end
    end
    puts mcr_atrs.to_xml(:include => :atrs)
    @mr.mcr_atrs_attributes=mcr_atrs
    pass=true
    @mr.mcr_atrs.each do |mcr|
      if not mcr.save
        pass=false
      end
      mcr.atrs.each do |atr|
        if not atr.save
          pass=false
        end
      end
    end
    respond_to do |format|
      if pass
        @mr.save
        format.html { redirect_to session[:return_to], notice: 'Parámetros creados satisfactoriamente.' }
        format.json { head :no_content }
      else
        @mr.mcr_atrs.each do |mcratr|
          mcratr.destroy
        end
        format.html { render action: "new" }
        format.json { render json: @mr.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    man_rsc=ManRsc.find(params[:id])
    mcratrs = man_rsc.mcr_atrs

    if man_rsc.mngbl
      #Remueve el MR a través de una llamada al webservice del núcleo
      http = Net::HTTP.new("192.168.119.163",9999)
      post_params = {'ip' => man_rsc.conn.ip, 'port' => man_rsc.conn.port}
      request = Net::HTTP::Delete.new("/mbs/#{man_rsc.domain}/#{man_rsc.name}")
      request.set_form_data(post_params)
      begin
        response = http.request(request)
      rescue Errno::ECONNREFUSED
      end
    end
    mcratrs.each do |mcratr|
      mcratr.destroy
    end
    man_rsc.mngbl=false
    man_rsc.alrtbl=false
    man_rsc.save
    respond_to do |format|
      format.html { redirect_to :back, notice: t('forms.delparams.notice')   }
      format.json { head :no_content }
    end
  end

end
