RSpec::Matchers.define(:have_attribute) do |attribute|
  match do |object|
    expect(object).to respond_to(attribute.to_sym)
    expect(object).to respond_to("#{attribute}=".to_sym)
  end
end

shared_examples_for "required attribute" do
  before { subject.send("#{attribute}=".to_sym, ' ') }
  it { should_not be_valid }
end

shared_examples_for "attribute with max length" do
  before { subject.send("#{attribute}=".to_sym, 'x' * too_long) }
  it { should_not be_valid }
end

shared_examples_for "unique attribute" do
  let(:duplicate_object) { FactoryGirl.create(subject.class) }
  before do
    duplicate_object.send(
      "#{attribute}=".to_sym,
      subject.send(attribute.to_sym)
    )
    subject.save!
  end
  specify { expect(duplicate_object).to_not be_valid }
end
