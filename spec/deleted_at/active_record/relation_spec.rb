require "spec_helper"

describe DeletedAt::ActiveRecord::Relation do

  context "models using deleted_at" do

    it "#destroy should set deleted_at" do
      DeletedAt.install(User)
      User.create(name: 'bob')
      User.create(name: 'john')
      User.create(name: 'sally')

      User.first.destroy

      expect(User.count).to eq(2)
      expect(User::All.count).to eq(3)
      expect(User::Deleted.count).to eq(1)
      DeletedAt.uninstall(User)
    end

    it "#delete should set deleted_at" do
      DeletedAt.install(User)
      User.create(name: 'bob')
      User.create(name: 'john')
      User.create(name: 'sally')

      User.first.delete

      expect(User.count).to eq(2)
      expect(User::All.count).to eq(3)
      expect(User::Deleted.count).to eq(1)
      DeletedAt.uninstall(User)
    end

    context '#destroy_all' do
      it "should set deleted_at" do
        DeletedAt.install(User)
        User.create(name: 'bob')
        User.create(name: 'john')
        User.create(name: 'sally')

        User.all.destroy_all

        expect(User.count).to eq(0)
        expect(User::All.count).to eq(3)
        expect(User::Deleted.count).to eq(3)
        DeletedAt.uninstall(User)
      end

      it "with conditions should set deleted_at" do
        DeletedAt.install(User)
        User.create(name: 'bob')
        User.create(name: 'john')
        User.create(name: 'sally')

        User.all.destroy_all(name: 'bob')

        expect(User.count).to eq(2)
        expect(User::All.count).to eq(3)
        expect(User::Deleted.count).to eq(1)
        DeletedAt.uninstall(User)
      end
    end

    context '#delete_all' do
      it "should set deleted_at" do
        DeletedAt.install(Animals::Dog)
        Animals::Dog.create(name: 'bob')
        Animals::Dog.create(name: 'john')
        Animals::Dog.create(name: 'sally')

        Animals::Dog.all.delete_all

        expect(Animals::Dog.count).to eq(0)
        expect(Animals::Dog::All.count).to eq(3)
        expect(Animals::Dog::Deleted.count).to eq(3)
        DeletedAt.uninstall(Animals::Dog)
      end

      it "with conditions should set deleted_at" do
        DeletedAt.install(Animals::Dog)
        Animals::Dog.create(name: 'bob')
        Animals::Dog.create(name: 'john')
        Animals::Dog.create(name: 'sally')

        Animals::Dog.all.delete_all(name: 'bob')

        expect(Animals::Dog.count).to eq(2)
        expect(Animals::Dog::All.count).to eq(3)
        expect(Animals::Dog::Deleted.count).to eq(1)
        DeletedAt.uninstall(Animals::Dog)
      end
    end

  end

  context "models not using deleted_at" do

    it "#destroy should actually delete the record" do
      Comment.create(title: 'Agree')
      Comment.create(title: 'Disagree')
      Comment.create(title: 'Defer')

      Comment.first.destroy

      expect(Comment.count).to eq(2)
    end

    it "#delete should actually delete the record" do
      Comment.create(title: 'Agree')
      Comment.create(title: 'Disagree')
      Comment.create(title: 'Defer')

      Comment.first.delete

      expect(Comment.count).to eq(2)
    end

    context '#destroy_all' do
      it "should actually delete records" do
        Comment.create(title: 'Agree')
        Comment.create(title: 'Disagree')
        Comment.create(title: 'Defer')

        Comment.all.destroy_all

        expect(Comment.count).to eq(0)
      end

      it "with conditions should actually delete records" do
        Comment.create(title: 'Agree')
        Comment.create(title: 'Disagree')
        Comment.create(title: 'Defer')

        Comment.all.destroy_all(title: 'Disagree')

        expect(Comment.count).to eq(2)
      end
    end

    context '#delete_all' do
      it "should actually delete records" do
        Comment.create(title: 'Agree')
        Comment.create(title: 'Disagree')
        Comment.create(title: 'Defer')

        Comment.all.delete_all

        expect(Comment.count).to eq(0)
      end

      it "with conditions should actually delete records" do
        Comment.create(title: 'Agree')
        Comment.create(title: 'Disagree')
        Comment.create(title: 'Defer')

        Comment.all.delete_all(title: 'Agree')

        expect(Comment.count).to eq(2)
      end
    end

  end

end