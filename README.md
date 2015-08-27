#SFT
##Rikli Jones Senior Fit Test
###Vital Aging Network

```
vagrant up
vagrant ssh
cd /vagrant
bundle install
rails s
```

### Need phantomjs for tests.  Until we can automate this in vagrant:
```
cd ~
export PHANTOM_JS="phantomjs-1.9.8-linux-x86_64"
wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2
sudo tar xvjf $PHANTOM_JS.tar.bz2
```
(Wait for download)
```
sudo mv $PHANTOM_JS /usr/local/share
sudo ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
phantomjs --version
```
