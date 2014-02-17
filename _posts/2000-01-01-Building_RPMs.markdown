`yum install rpmdevtools -y`\
`rpmdev-setuptree`\
`cd ~/rpmbuild`\
`cd SOURCES`

Now put your tar file in the sources directory.

`rpmdev-newspec ../SPECS/foo.spec`

Edit the spec. Then run

`rpmbuild -ba ../SPECS/foo.spec`

For more information on the spec, see [RPM Spec
File](RPM Spec File "wikilink")

<Category:RPM>
