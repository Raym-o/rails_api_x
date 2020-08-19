ActiveAdmin.register Product do
  permit_params :title,
                :description,
                :price,
                images: [],
                collection_products_attributes: %i[id collection_id product_id _destroy]

  index do
    selectable_column
    column :id
    column :title
    column :description
    column :price
    column :images do |product|
      product.images.count if product.images.present?
    end
    column :collections do |product|
      product.collections.map(&:title).join(', ').html_safe
    end
    actions
  end

  show do |product|
    attributes_table do
      row :title
      row :description
      row :price
      row :images do |pro|
        pro.images.map do |pi|
          image_tag(pi, size: '64')
        end
      end
      row :collections do
        product.collections.map(&:title).join(', ').html_safe
      end
    end
  end

  member_action :delete_product_image, method: :delete do
    @pic = ActiveStorage::Attachment.find(params[:id])
    @pic.purge_later
    redirect_back(fallback_location: edit_admin_product_path)
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Product' do
      f.input :title
      f.input :description
      f.input :price

      f.input :images, as: :file, label: 'Images', input_html: { multiple: true }
      if f.object.images.attached?
        f.object.images.each do |m|
          div
          span image_tag(m, size: '64')
          span link_to 'delete', delete_product_image_admin_product_path(m.id), method: :delete, data: { confirm: 'Are you sure?' }
        end
      end

      f.has_many :collection_products, allow_destroy: true do |n_f|
        n_f.input :collection
      end
    end
    f.actions
  end
end
