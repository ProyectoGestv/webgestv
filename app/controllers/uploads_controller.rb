# -*- encoding : utf-8 -*-
class UploadsController < ApplicationController
  def new
    puts request.referer
    puts '/////////////////////////////////////'
    session[:return_to]=request.referer
    tmp = params[:mr][:file].tempfile
    f=File.open(tmp)
    doc = Nokogiri::XML(f)
    f.close
    @mr = nil
    if doc.errors.empty?
      @mr=ManRsc.find(params[:id])
      doc.xpath('//mcr-atrs/mcr-atr').each do |n1|
        mcr=McrAtr.new
        n1.elements.each do |n2|
          if n2.name == 'name'
            mcr.name=n2.text
          elsif n2.name == 'desc'
            mcr.desc=n2.text
          elsif n2.name == 'ref-prot'
            mcr.ref_prot=n2.text
          elsif n2.name == 'type'
            mcr.type=n2.text
          elsif n2.name == 'atrs'
            n2.elements.each do |n3|
              atr=Atr.new
              n3.elements.each do |n4|
                if n4.name == 'name'
                  atr.name=n4.text
                elsif n4.name == 'desc'
                  atr.desc=n4.text
                elsif n4.name == 'ref-prot'
                  atr.ref_prot=n4.text
                elsif n4.name == 'type'
                  atr.type=n4.text
                elsif n4.name == 'rdbl'
                  atr.rdbl=n4.text
                elsif n4.name == 'wtbl'
                  atr.wtbl=n4.text
                elsif n4.name == 'value'
                  atr.value=n4.text
                end
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
    puts '////////////////////////////'
    @mr = ManRsc.find(params[:id])
    mcr_atrs=nil
    params.each do |key, value|
      #if ['serv', 'net_ele', 'laynet_ele'].include?(key)
      if %w{serv net_ele laynet_ele}.include?(key)
        mcr_atrs=params[key][:mcr_atrs_attributes]
        break
      end
    end
    #mcr_atrs=params[:serv][:mcr_atrs_attributes]
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
    mcratrs = ManRsc.find(params[:id]).mcr_atrs
    mcratrs.each do |mcratr|
      mcratr.destroy
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: t('forms.delparams.notice')   }
      format.json { head :no_content }
    end
  end

end
