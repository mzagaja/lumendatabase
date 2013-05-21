require 'spec_helper'

describe 'home/index.html.erb' do
  it 'shows metadata and a link to each of its notices' do
    notices = build_stubbed_list(:notice, 3, date_sent: 1.hour.ago)
    assign(:notices, notices)

    render

    notices.each do |notice|
      within("#notice_#{notice.id}") do |node|
        expect(node.text).to include notice.title
        expect(node.text).to include notice.date_sent.to_s
        expect(node).to contain_link notice_path(notice)
      end
    end
  end

  def contain_link(path)
    have_css(%{a[href="#{path}"]})
  end

end
