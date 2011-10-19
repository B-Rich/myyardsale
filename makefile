index.html : content.html header.html footer.html
	cat header.html > index.html
	cat content.html >> index.html
	cat footer.html >> index.html
	sed -i s/XXXXX/`git rev-parse HEAD`/ index.html

content.html : content.md
	markdown content.md > content.html

clean:
	-rm index.html content.html

upload:
	scp -r index.html images kudu:websites/haenel.co/yardsale/
	ssh kudu 'chmod a+rX -vR websites/haenel.co/yardsale/'
