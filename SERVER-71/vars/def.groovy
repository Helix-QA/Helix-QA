def relUpdateRep(String vrunnerPath, String dbRelease, String dbUserRelease, String repositoryReleaseFitness) {
    script {
        bat """
        chcp 65001
        @call ${vrunnerPath} session kill --with-nolock --db ${dbRelease} --db-user ${dbUserRelease}
        @call ${vrunnerPath} loadrepo --storage-name ${repositoryReleaseFitness} --storage-user VATest --ibconnection /Slocalhost/${dbRelease} --db-user ${dbUserRelease}
        @call ${vrunnerPath} updatedb --ibconnection /Slocalhost/${dbRelease} --db-user ${dbUserRelease}
        """
    }
}

return this